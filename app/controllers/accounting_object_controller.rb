class AccountingObjectController < ApplicationController

  before_action(:require_authentication)

  def index
    user = User.find_by(remember_token_digest: session[:user_id])
    @accounting_objects = user.accounting_object.order(id: :desc)
  
    @accounting_object_new = AccountingObject.new
    @select_kind_of_object = KindOfObject.all
  end

  def new
    @accounting_object_new = AccountingObject.new
    @select_kind_of_object = KindOfObject.all
  end

  def show
   
    user = User.find_by(remember_token_digest: session[:user_id])
    acc_object_decript = Base64.decode64(params[:id])
      @date_end = Time.now
      @date_start = @date_end.minus_with_duration(30.days)

    if params['[date_field_operations]'].present? then
      begin
        @date_start = Time.parse(params['[date_field_operations]'][:date_start]).beginning_of_day 
        @date_end = Time.parse(params['[date_field_operations]'][:date_end]).end_of_day #|| Time.now
      rescue ArgumentError => e
        @date_end = Time.now
        @date_start = @date_end.minus_with_duration(30.days)
      end
    end

    if user.accounting_object_ids.include?(acc_object_decript.to_i) then
      @acc_object = AccountingObject.find(acc_object_decript)
      @acc_object_encript =  Base64.encode64(@acc_object.id.to_s)

      @pagy, @all_operation_for_acc_object = pagy Operation
      .where(accounting_object_id: @acc_object.id)
      .where(created_at: @date_start..@date_end)
      .order(created_at: :desc)

      #@all_sum = @all_operation_for_acc_object.sum(:amount_of_money)

      money_category = {}
      temp_arr = []
      category_colors = {}

      @all_operation_for_acc_object.each do |op|
        money_category[op.category.name_category] = 0
      end

      @all_operation_for_acc_object.each do |op|
        temp_arr.push([op.category.name_category, op.amount_of_money.to_i])
        category_colors[op.category.name_category] = op.category.color_category.delete(';')
      end

      temp_arr.each do |arr|
        money_category[arr[0]] += arr[1]
      end

      @data_category_chart = {data_name_and_money: money_category, data_colors: category_colors}

      
=begin
      @all_operation_group_by_category_id = Operation
      .where(accounting_object_id: @acc_object.id)
      .where(created_at: @date_start..@date_end)
      .group(:category_id).count

      @all_operation_to_chart = @all_operation_group_by_category_id.inject({}) do |result, (k, v)| 
        result[Category.find(k).name_category]=v 
        result
      end
=end

      render(:show)
    else
      flash.now[:message] = '1 error from accounting_object#show'
      redirect_to(root_path)
    end

  end

  def create

    user = User.find_by(remember_token_digest: session[:user_id])
    params_create = accounting_object_params.merge!(user_id: user.id)
    acc_object = AccountingObject.new(params_create)

    if acc_object.save then
      flash.now[:message] = 'acc_object created'
      redirect_to(accounting_object_index_path)
    else
      @accounting_object_new = acc_object
      @select_kind_of_object = KindOfObject.all

      #flash[:message] = acc_object.errors.full_messages
      render(:new)
    end
  
  end

  def edit

    user = User.find_by(remember_token_digest: session[:user_id])
    acc_object_decript = Base64.decode64(params[:id])
    acc_object = AccountingObject.find(acc_object_decript)


    if user.id == acc_object.user_id then
      @select_kind_of_object = KindOfObject.all
      @acc_object_user = acc_object
    else
      redirect_to(root_path)
    end
  end

  def update

    user = User.find_by(remember_token_digest: session[:user_id])
    acc_object = AccountingObject.find(params[:id])

    if user.id == acc_object.user_id then

      if acc_object.update(accounting_object_params) then        
        redirect_to(accounting_object_index_path)
      else
        @accounting_object_new = AccountingObject.new
        @select_kind_of_object = KindOfObject.all
        @acc_object_user = acc_object

        render(:edit)
      end

    else
      flash[:message] = '1 error from accounting_object#update'
      redirect_to(root_path)
    end
  end

  def destroy

    user = User.find_by(remember_token_digest: session[:user_id])
    acc_object = AccountingObject.find(params[:id])

    if user.id == acc_object.user_id then

      if acc_object.destroy then
        flash[:message] = 'acc_object delete'
        redirect_to(root_path)
      else
        flash[:message] = '2 error from accounting_object#delete'
        render(:new)
      end
      
    else
      flash[:message] = '1 error from accounting_object#delete'
      redirect_to(root_path)
    end
  
  end

  private

  def accounting_object_params
    cleared_params = {}

    cleared_params.merge!(params.require(:accounting_object).permit(:name_object, :type_object_id))
    cleared_params.merge!(params.require(:select_kind).permit(:kind_of_object_id))
  end

end
