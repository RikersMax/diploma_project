class AccountingObject < ApplicationRecord
  belongs_to :user
  belongs_to :type_object
  belongs_to :kind_of_object
  
  has_many :category, dependent: :destroy

  validates(:user, presence: true)
  validates(:type_object, presence: true)
  validates(:kind_of_object, presence: true)
  validates(:name_object, { presence: true, length: {minimum: 4, maximum: 64 }, uniqueness: { scope: :user_id }})

  # Допустимые значения для type_object и kind_of_object
  #TYPE_OBJECTS = [1, 2].freeze
  #KIND_OF_OBJECTS = %w[1 2].freeze

  validates(:type_object_id, inclusion: { in: [1, 2] })
  #validates(:kind_of_object, inclusion: { in: KIND_OF_OBJECTS }, if: :kind_of_object_present?)


  private

  # def kind_of_object_present?
  #  !kind_of_object.nil?
  # end
end
