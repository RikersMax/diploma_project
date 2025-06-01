class AccountingObject < ApplicationRecord
  belongs_to :user
  belongs_to :type_object
  belongs_to :kind_of_object
  
  has_many :category, dependent: :destroy

  validates(:user, presence: true)
  validates(:type_object, presence: true)
  validates(:kind_of_object, presence: true)
  validates(:name_object, { presence: true, length: {minimum: 1, maximum: 64 }, uniqueness: { scope: :user_id }})
  validates(:type_object_id, inclusion: { in: [1, 2] })

end
