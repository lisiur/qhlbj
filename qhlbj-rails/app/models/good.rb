class Good < ApplicationRecord
	belongs_to :category, optional: true
end
