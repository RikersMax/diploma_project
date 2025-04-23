class AccountingObject < ApplicationRecord
  belongs_to :user
  belongs_to :type_object
  belongs_to :kind_of_object
end
