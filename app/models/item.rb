class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :name, :description, presence: true
  has_many_attached :photos
end
