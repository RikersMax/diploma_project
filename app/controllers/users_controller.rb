class UsersController < ApplicationController

  before_action(:require_authentication, only: %i[show edit update destroy])
  before_action(:no_require_authentication, only: %i[new create])

	def index
    @users = User.all
    render('example_page')
  end

  def new    
    @user = User.new
  end

  def show
    @user = User.find_by(remember_token_digest: session[:user_id])
    @accounting_objects = @user.accounting_object #['test1', 'test2', 'test3', 'test4']#@user.accounting_object
  end


  def create

    @user = User.new(user_params)
    #r_connect = Redis.new(db: 0)
    #r_get = r_connect.get(@user.remember_token)    
    #r_deserial = JSON.parse(r_get).symbolize_keys
    #render(plain: r_deserial) and return

    if @user.save then
      @user.remember_me
      #r_connect.setex(@user.remember_token, 1000 ,@user.attributes.to_json)

      flash[:message] = 'user created'
      session[:user_id] = @user.remember_token
      redirect_to(root_path)
      
      #render(plain: session[:user_id])
    else
      flash[:message] = @user.errors.full_messages
      render :new
    end
  end



  def edit
    @user = User.find_by(remember_token_digest: session[:user_id])
  end

  def update
    user = User.find_by(remember_token_digest: session[:user_id])

    if user.update(user_params) then
      flash['message'] = 'Your update profile'
      redirect_to(root_path)
    else
      flash['message'] = t('flash.danger')
      render(:edit)
    end
  end

  def destroy

  end



  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end
 
end
