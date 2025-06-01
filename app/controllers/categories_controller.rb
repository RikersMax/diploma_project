class CategoriesController < ApplicationController

  def index

    @acc_object_encript = params[:accounting_object_id]
    
    acc_object_decript = Base64.decode64(@acc_object_encript)    

    user = User.find_by(remember_token_digest: session[:user_id])
    @acc_object = AccountingObject.find(acc_object_decript)

    check_user_request(user, @acc_object) #проверка

    @form_category = Category.new
    @form_category.accounting_object = @acc_object

    @pagy, @category_list = pagy(Category.where(accounting_object_id: @acc_object.id), limit: 8)
  end

  def create

    user = User.find_by(remember_token_digest: session[:user_id])
    acc_object_decript = Base64.decode64(params[:category][:accounting_object_id])    
    @acc_object = AccountingObject.find(acc_object_decript)

    check_user_request(user, @acc_object)

    @form_category = Category.new(name_category: params[:category][:name_category], 
      accounting_object_id: @acc_object.id,
      color_category: params[:category][:color_category])

    if @form_category.save then
      flash[:message] = 'category created'
      redirect_to(categories_path(accounting_object_id: params[:category][:accounting_object_id]))
    else
      category_name_placeholder = @form_category.name_category
      category_errors = @form_category.errors.full_messages
      redirect_to(categories_path(
        accounting_object_id: params[:category][:accounting_object_id], 
        category_errors: category_errors,
        category_name_placeholder: category_name_placeholder
        ))
    end    
   
  end

  def edit
 
    @acc_object_encript = params[:accounting_object_id]
    acc_object_decript = Base64.decode64(@acc_object_encript)    

    user = User.find_by(remember_token_digest: session[:user_id])
    acc_object = AccountingObject.find(acc_object_decript)

    check_user_request(user, acc_object) #проверка

    category_id_decript = Base64.decode64(params[:id])
    @category = Category.find(category_id_decript)
    
  end

  def update
    category_update = Category.find(params[:id])

    user = User.find_by(remember_token_digest: session[:user_id])
    acc_object_decript = Base64.decode64(params[:category][:accounting_object_id])    
    @acc_object = AccountingObject.find(acc_object_decript)

    check_user_request(user, @acc_object)

    attributes_update = {name_category: params[:category][:name_category], 
      accounting_object_id: @acc_object.id,
      color_category: params[:category][:color_category]
    }

    if category_update.update(attributes_update) then
      flash[:message] = 'category update'
      redirect_to(categories_path(accounting_object_id: params[:category][:accounting_object_id]))
    else
      @acc_object_encript = params[:category][:accounting_object_id]
      @category = category_update
      
      render(:edit)
    end
       
  end

  def destroy
    category_delete = Category.find(params[:id])

    user = User.find_by(remember_token_digest: session[:user_id])
    @acc_object_decript = Base64.decode64(params[:accounting_object_id])    
    @acc_object = AccountingObject.find(@acc_object_decript)

    check_user_request(user, @acc_object)

    if category_delete.delete then
      flash[:message] = 'category delete'
      redirect_to(categories_path(accounting_object_id: params[:accounting_object_id]))
    else
      @acc_object_encript = params[:accounting_object_id]
      @category = category_update
      flash[:message] = '2 error form categories#create'
      render(:edit)
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
