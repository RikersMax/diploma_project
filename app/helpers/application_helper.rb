module ApplicationHelper
	def render_navbar
    render(partial: 'shared/navbar')
  end

  def render_footer
    render(partial: 'shared/footer')
  end
  
  def render_message
    render(partial: 'shared/message')
  end

end
