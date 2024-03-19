class Review < ApplicationRecord
  belongs_to :deal
  validates :rating, :content, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :deal, uniqueness: { scope: :user, message: "You have already reviewed this deal" }
  validates :content, length: { minimum: 10, maximum: 1000 }
end
