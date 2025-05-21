class ApplicationController < ActionController::Base
	include RedisModule
	include Pagy::Backend
	include UserAuthenticate 
end
