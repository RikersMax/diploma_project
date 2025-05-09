class CategoriesController < ApplicationController
  before_action(:check_user_request, only: %i[index])

  def index
    @category_new = Category.new
    @category_new.accounting_object = @acc_object

    @category_list = Category.where(accounting_object_id: @acc_object.id)
  end

  def create
    render(plain: params)    
  end

  def show
  end

  def new
  end

  def update
  end

  def destroy
  end


  def check_user_request
    @user = User.find_by(remember_token_digest: session[:user_id])
    @acc_object = AccountingObject.find(params[:accounting_object_id])

    if @acc_object.user == @user then
      return
    else
      flash[:message] = '1 error from categories#check user'
      redirect_to(root_path)
    end
  end
end
