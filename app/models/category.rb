class Category < ApplicationRecord
  validates :name, presence: true, length: (3..25)
  validates_uniqueness_of :name
end