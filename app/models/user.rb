class User < ApplicationRecord

  attr_accessor :remember_token, :test_string
	
	has_many :accounting_object

  validates(:user_name, {presence: true, length: {mi8nimum: 4, maximum: 64 }})
  validates(:email, {
    presence: true, 
    uniqueness: true, 
    format: { with: URI::MailTo::EMAIL_REGEXP },
    length: { maximum: 254}
  })
  validates(:password, {length: { minimum: 3, maximum: 20 }, confirmation: true, allow_blank: true})  
  # проверяет идентиччность полей password и password_confirmation
  # allow_blank: true -- чтобы при изменении профиля поле с паролем было пустым и из-за этого небыло изменеий пароля


	has_secure_password

  def remember_me
    self.remember_token = SecureRandom.urlsafe_base64
    update_column(:remember_token_digest, remember_token)
    return remember_token    
  end

  def remember_token_authenticated(remember_token)
    BCrypt::Password.new(remember_token_digest).is_password?(remember_token)
  end

  private

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
	
end
