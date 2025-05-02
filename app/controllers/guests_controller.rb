class GuestsController < ApplicationController
	def index
		@guest_page = true
		flash[:message] = 'my message'
	end
end
