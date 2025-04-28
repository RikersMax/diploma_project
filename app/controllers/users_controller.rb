class UsersController < ApplicationController

	def index
    @users = User.all
  end

  def create
=begin

    @user = User.new(user_params)
    #r_connect = Redis.new(db: 0)
    #r_get = r_connect.get(@user.remember_token)    
    #r_deserial = JSON.parse(r_get).symbolize_keys
    #render(plain: r_deserial) and return

    if @user.save then
      @user.remember_me
      r_connect.setex(@user.remember_token, 1000 ,@user.attributes.to_json)

      session[:user_id] = @user.remember_token
      redirect_to(root_path)
      
      #render(plain: session[:user_id])
    else
      render :new
    end
=end

  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_exits
    if user_signed_in? then
      redirect_to(root_path)
    end
  end
 
end
