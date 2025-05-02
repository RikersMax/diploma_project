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
end
