class Category < ApplicationRecord
  belongs_to :accounting_object
  has_one :operation

  validates(:color_category, format: {with: /\A#[0-9A-Fa-f]{3,6};\z/, message: "неверный формат цвета"})
  validates(:name_category, {presence: true, length: {minimum: 4, maximum: 64}})
  
end
