class GuestsController < ApplicationController
	def index
		@guest_page = {guest_page: true, guest_navbar: 'navbar'}
		flash[:message] = 'my message'
	end
end
