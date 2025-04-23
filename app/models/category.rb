class Category < ApplicationRecord
  belongs_to :accounting_object
  has_one :operation
end
