module UserAuthenticate
  extend ActiveSupport::Concern

  included do

    private

    def current_user

      if session[:user_id].present? then

        redis_user = r_connect.get("user:user_id:#{session[:user_id]}")

        if redis_user.present? then
          redis_user_parse = JSON.parse(redis_user).symbolize_keys
          @current_user = User.new(redis_user_parse)
        else
          @current_user ||= User.find_by(remember_token_digest: session[:user_id])         
          session[:user_id] = @current_user.remember_me

          user_attributes = @current_user.attributes.slice('id', 'user_name', 'email', 'remember_token_digest')
          r_connect.setex("user:user_id:#{@current_user.remember_token}", 1000 ,user_attributes.to_json)
        end

      end
      return @current_user
      
    end

    def user_signed_in?
      current_user.present?
    end

    def user_compliete_session
      r_connect.del("user:user_id:" + session[:user_id])
      session.delete(:user_id)
    end

    def require_authentication
      return if user_signed_in?
      
      flash[:message] = 'message from require_authentication'
      redirect_to(root_path)
    end

    def no_require_authentication
      return if !user_signed_in?
        
      flash[:message] = 'message from no_authentication_required'
      redirect_to(root_path)
    end

    helper_method :current_user, :user_signed_in?

  end
end