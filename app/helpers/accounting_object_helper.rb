module AccountingObjectHelper
	def btn_sign_in_sign_up(controller)
		result = {}

		if controller == 'session' then
			result = {btn: 'sign_in'}
		elsif controller == 'user'
			result = {btn: 'sign_up'}
		end

		return(result)
	end
end
