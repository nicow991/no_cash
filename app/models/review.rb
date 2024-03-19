class Review < ApplicationRecord
  # belongs_to :user
  belongs_to :deal
  # validates :rating, :content, presence: true
  # validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :deal, uniqueness: { scope: :user, message: "You have already reviewed this deal" }
  # validates :deal_must_be_completed
  # validates :reviewer_must_be_different_from_user
  # validates :reviewer_must_be_participant_of_deal
  # validates :reviewer_must_be_participant_of_chatroom
  validates :content, length: { minimum: 10, maximum: 1000 }
end
