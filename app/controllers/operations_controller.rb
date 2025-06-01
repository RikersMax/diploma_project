class OperationsController < ApplicationController

  before_action(:require_authentication)

  def index
  end

  def new
    @acc_object_encript = params[:accounting_object_id]
    acc_object_decript = Base64.decode64(@acc_object_encript)
    categories_all = Category.where(accounting_object_id: acc_object_decript)
    @select_categories = categories_all.inject([]) {|arr, item| arr.push([item.name_category, item.id])}

    @operation = Operation.new

  end

  def show
  end

  def create

    user = User.find_by(remember_token_digest: session[:user_id])

    @acc_object_encript = params[:operation][:accounting_object_id]
    acc_object_decript = Base64.decode64(@acc_object_encript)
    acc_object = AccountingObject.find(acc_object_decript)

    check_user_request(user, acc_object)

    operation_params = {}
    operation_params[:accounting_object_id] = acc_object_decript
    operation_params[:amount_of_money] = params[:operation][:amount_of_money]
    operation_params[:category_id] = params[:operation][:category_id]
    operation_params[:data_stamp] = params[:operation][:data_stamp]
    operation_params[:description] = params[:operation][:description]

    @operation = Operation.new(operation_params)

    #render(plain: operation)

    if @operation.save then
      flash[:message] = 'operation create'      
      redirect_to(accounting_object_path(id: @acc_object_encript))
    else
      categories_all = Category.where(accounting_object_id: acc_object_decript)
      @select_categories = categories_all.inject([]) {|arr, item| arr.push([item.name_category, item.id])}
      #flash[:message] = @operation.errors.full_messages
      render(:new)
    end
   
  end

  def edit   
    user = User.find_by(remember_token_digest: session[:user_id])

    @acc_object_encript = params[:accounting_object_id]
    acc_object_decript = Base64.decode64(@acc_object_encript)
    acc_object = AccountingObject.find(acc_object_decript)

    check_user_request(user, acc_object)

    categories_all = Category.where(accounting_object_id: acc_object_decript)
    @select_categories = categories_all.inject([]) {|arr, item| arr.push([item.name_category, item.id])}

    @operation = Operation.find(Base64.decode64(params[:id]))
    @operation_encod = params[:id]

  end

  def update


    user = User.find_by(remember_token_digest: session[:user_id])
    @acc_object_encript = params[:operation][:accounting_object_id]
    acc_object_decript = Base64.decode64(@acc_object_encript)
    acc_object = AccountingObject.find(acc_object_decript)

    check_user_request(user, acc_object)

    attributes_update = {amount_of_money: params[:operation][:amount_of_money], 
      accounting_object_id: acc_object_decript,
      category_id: params[:operation][:category_id],
      data_stamp: params[:operation][:data_stamp],
      description: params[:operation][:description]
    }

    @operation = Operation.find(Base64.decode64(params[:operation][:id_encod_operation]))

    if @operation.update(attributes_update) then
      flash[:message] = 'operation update'      
      redirect_to(accounting_object_path(id: @acc_object_encript))
    else
      categories_all = Category.where(accounting_object_id: acc_object_decript)
      @select_categories = categories_all.inject([]) {|arr, item| arr.push([item.name_category, item.id])}
      flash[:message] = 'error operation#update'
      render(:new)
    end
  end

  def destroy
    user = User.find_by(remember_token_digest: session[:user_id])
    @acc_object_encript = params[:accounting_object_id]
    acc_object_decript = Base64.decode64(@acc_object_encript)
    acc_object = AccountingObject.find(acc_object_decript)

    check_user_request(user, acc_object)

    operation_encod = params[:id]
    operation = Operation.find(Base64.decode64(params[:id]))


    if operation.destroy then
      flash[:message] = 'operation delete'
      redirect_to(accounting_object_path(@acc_object_encript))
    else
      flash[:message] = '2 error from operation#delete'
      render(:new)
    end
  end

  private

  def check_user_request(user, acc_object)
    if acc_object.user == user then
      return
    else
      flash[:message] = '1 error from categories#check user'
      redirect_to(root_path)
    end
  end
end
