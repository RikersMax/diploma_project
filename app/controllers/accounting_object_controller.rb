class AccountingObjectController < ApplicationController

  before_action(:require_authentication)

  def index
    user = User.find_by(remember_token_digest: session[:user_id])
    @accounting_objects = user.accounting_object 
  
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

    if user.accounting_object_ids.include?(acc_object_decript.to_i) then
      @acc_object = AccountingObject.find(acc_object_decript)
      @acc_object_encript =  Base64.encode64(@acc_object.id.to_s)

      @pagy, @all_operation_for_acc_object = pagy Operation.where(accounting_object_id: @acc_object.id)

      render(:show)
    else
      flash[:message] = '1 error from accounting_object#show'
      redirect_to(root_path)
    end

  end

  def create
    user = User.find_by(remember_token_digest: session[:user_id])
    params_create = accounting_object_params.merge!(user_id: user.id)

    acc_object = AccountingObject.new(params_create)

    if acc_object.save then
      flash[:message] = 'acc_object created'
      redirect_to(accounting_object_index_path)
    else
      debugger
      @accounting_object_new = AccountingObject.new
      @select_kind_of_object = KindOfObject.all

      flash[:message] = acc_object.errors.full_messages
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
      flash[:message] = '1 error from accounting_object#edit'
      redirect_to(root_path)
    end
  end


  def update
    user = User.find_by(remember_token_digest: session[:user_id])
    acc_object = AccountingObject.find(params[:id])

    if user.id == acc_object.user_id then

      if acc_object.update(accounting_object_params) then
        flash[:message] = 'acc_object created'
        redirect_to(root_path)
      else
        @accounting_object_new = AccountingObject.new
        @select_kind_of_object = KindOfObject.all

        flash[:message] = '2 error from accounting_object#update'
        render(:new)
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
