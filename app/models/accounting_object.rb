class AccountingObject < ApplicationRecord
  belongs_to :user
  belongs_to :type_object
  belongs_to :kind_of_object

  validates(:user, presence: true)
  validates(:type_object, presence: true)
  validates(:kind_of_object, presence: true)

  # Допустимые значения для type_object и kind_of_object
  TYPE_OBJECTS = %w[expense income].freeze
  KIND_OF_OBJECTS = %w[personal_object shared_object].freeze

  validates(:name_object, { presence: true, length: {minimum: 4, maximum: 64 }, uniqueness: { scope: :user_id }})
  validates(:type_object, inclusion: { in: TYPE_OBJECTS }, if: :type_object_present?)
  validates(:kind_of_object, inclusion: { in: KIND_OF_OBJECTS }, if: :kind_of_object_present?)


  private

  def type_object_present?
   !type_object.nil?
  end

  def kind_of_object_present?
   !kind_of_object.nil?
  end
end
