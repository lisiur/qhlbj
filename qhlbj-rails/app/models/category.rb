class Category < ApplicationRecord
	has_many :goods
	has_many :subcategories, class_name: "Category", foreign_key: "supcategory_id", dependent: :destroy
	belongs_to :supcategory, class_name: "Category", optional: true

	validates :name, presence: true
end
