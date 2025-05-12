class Operation < ApplicationRecord
  belongs_to :accounting_object
  belongs_to :category

  validates(:accounting_object_id, presence: true)
  validates(:category_id, presence: true)
  validates(:amount_of_money, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false)
  #validates(:data_stamp, {date_time: true})
  validates(:description, length: { maximum: 1000 }, allow_blank: true)

end
