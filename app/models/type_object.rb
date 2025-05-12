class TypeObject < ApplicationRecord
	has_many :accounting_object

	validates_length_of(:name_type, maximum: 64)
	validates_uniqueness_of(:name_type)
end
