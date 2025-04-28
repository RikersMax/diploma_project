class GuestsController < ApplicationController
	def index
		flash[:message] = 'my message'
	end
end
