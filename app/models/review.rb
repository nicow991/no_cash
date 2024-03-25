class Review < ApplicationRecord
  belongs_to :deal
  belongs_to :user_reviewed, class_name: 'User', foreign_key: 'user_reviewed_id'
  belongs_to :user_reviewer, class_name: 'User', foreign_key: 'user_reviewer_id'
  validates :rating, :content, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :deal, uniqueness: { scope: :user_reviewer_id, message: "You have already reviewed this deal" }
  validates :deal, uniqueness: { scope: :user_reviewer_id, message: "You have already reviewed this deal" }
  validates :content, length: { minimum: 1, maximum: 500 }
end
