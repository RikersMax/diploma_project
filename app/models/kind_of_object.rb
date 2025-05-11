class KindOfObject < ApplicationRecord
	has_many :accounting_object

	validates_length_of :name_kind, maximum: 64
	validates_uniqueness_of :name_kind

end
