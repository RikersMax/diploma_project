class User < ApplicationRecord

  attr_accessor :remember_token, :old_password
	
	has_many :accounting_object
	
  has_secure_password(validations: false)

  validates(:user_name, {presence: true, length: {mi8nimum: 4, maximum: 64 }})
  validates(:email, {
    presence: true, 
    uniqueness: true, 
    format: { with: URI::MailTo::EMAIL_REGEXP },
    length: { maximum: 254}
  })
  validates(:password, 
    {length: { minimum: 4, maximum: 20 }, 
    confirmation: true, 
    allow_blank: true
  })  
  # confirmation: true -- проверяет идентиччность полей password и password_confirmation
  # allow_blank: true -- чтобы при изменении профиля поле с паролем было пустым и из-за этого небыло изменеий пароля

  #validate(:password_complexity)
  validate(:passowrd_presence)
  validate(:correct_old_password, on: :update, if: -> {password.present?})


  def remember_me
    self.remember_token = SecureRandom.urlsafe_base64
    update_column(:remember_token_digest, remember_token)
    return remember_token    
  end

  def remember_token_authenticated(remember_token)
    BCrypt::Password.new(remember_token_digest).is_password?(remember_token)
  end

  private

  def password_complexity    
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{3,20}$/

    errors.add(:password, 'Complexity requirement not met. Length should be 3-20 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character')
  end

  def passowrd_presence
    errors.add(:password, :blank) unless password_digest.present?
  end

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)
    #password_digest_was - возвращаяет старый дайджест пароль из БД
    errors.add(:old_password, 'old password in incorrect')
  end

  # def digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end
	
end
