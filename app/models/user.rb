class User < ApplicationRecord

	has_many :accounting_object

	has_secure_password
	
end
