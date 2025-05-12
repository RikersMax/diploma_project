class ApplicationController < ActionController::Base
	include Pagy::Backend
	include UserAuthenticate 
end
