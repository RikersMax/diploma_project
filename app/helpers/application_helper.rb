module ApplicationHelper
	def render_navbar
		nav_bar = ''

		if @guest_page then
			nav_bar = 'navbar'
		else
			nav_bar = 'shared/navbar'
		end

		return(nav_bar)
	end

	def btn_sign_in_sign_up(controller)
		result = {}

		if controller == 'session' then
			result = {btn: 'sign_in'}
		elsif controller == 'user'
			result = {btn: 'sign_up'}
		end

		return(result)
	end

	def create_or_update(model)
		result = ''
		if model.persisted? then
			result = 'update'
		else
			result = 'create'
		end

		return(result)		
	end
end
