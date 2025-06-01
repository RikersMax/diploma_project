class SessionsController < ApplicationController

  before_action(:no_require_authentication, only: %i[new create])
	before_action(:require_authentication, only: %i[destroy])

	def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      @user.remember_me
      
      #user_attributes = @user.attributes.transform_keys(&:to_sym).slice(:id, :name, :email)
      #user_attributes = @user.attributes.slice('id', 'name', 'email', 'remember_token_digest')
      #r_connect.setex(@user.remember_token, 1000 , user_attributes.to_json)

      session[:user_id] = @user.remember_token
      redirect_to(root_path)
    else
      flash.now[:message] = 'Неправильноый Email или пароль'
      render(:new)
    end

  end

  def destroy 
    user_compliete_session
    redirect_to(root_path)    
  end

end
