class Category < ApplicationRecord
  has_many :items
  has_many :preferences
  validates :name, presence: true
end
