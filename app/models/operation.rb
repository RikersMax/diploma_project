class Operation < ApplicationRecord
  belongs_to :accounting_object
  belongs_to :category
end
