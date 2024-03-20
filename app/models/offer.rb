class Offer < ApplicationRecord
  has_one :deal
  belongs_to :user
  has_one :offered_item, through: :user
  has_one :requested_item, through: :user
end
