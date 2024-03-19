class Offer < ApplicationRecord
  has_one :deal
  belongs_to :user
end
