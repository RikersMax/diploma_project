class SessionController < ApplicationController

  before_action(:no_require_authentication, only: %i[new create])
	before_action(:require_authentication, only: %i[destroy])

	def new
    @user = User.new
  end

  def create
   #render(plain: params)
    @user = User.find_by(email: session_params[:email])    

    if @user.present? && @user.authenticate(session_params[:password])
      @user.remember_me
      
      #user_attributes = @user.attributes.transform_keys(&:to_sym).slice(:id, :name, :email)
      #user_attributes = @user.attributes.slice('id', 'name', 'email', 'remember_token_digest')
      #r_connect.setex(@user.remember_token, 1000 , user_attributes.to_json)

      session[:user_id] = @user.remember_token
      redirect_to(root_path)
    else
      flash[:message] = 'message from session#creat'
      @user = User.new
      render(:new)
    end
  
  end

  def destroy 
    user_compliete_session
    redirect_to(root_path)    
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def user_exits
    if user_signed_in? then
      redirect_to(root_path)
    end
  end

end
