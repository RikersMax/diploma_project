class UsersController < ApplicationController

  before_action(:require_authentication, only: %i[show edit update])
  before_action(:no_require_authentication, only: %i[new create])

	def index    
  end

  def new    
    @user = User.new
  end

  def show
    @user = User.find_by(remember_token_digest: session[:user_id])
    @accounting_objects = @user.accounting_object 
  end

  def create
    @user = User.new(user_params)
   
    if @user.save then
      @user.remember_me

      session[:user_id] = @user.remember_token
      redirect_to(accounting_object_index_path)
    else     
      render :new
    end
  end

  def edit
    @user = User.find_by(remember_token_digest: session[:user_id])
  end

  def update
    @user = User.find_by(remember_token_digest: session[:user_id])

    if @user.update(user_params) then
      flash['message'] = 'Your update profile'
      redirect_to(user_path('user'))
    else
      render(:edit)
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :old_password)
  end
 
end
