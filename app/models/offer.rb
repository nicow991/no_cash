class Offer < ApplicationRecord
  has_one :deal
  belongs_to :item
  # belongs_to :user # this breaks for some reason. just use offer.item.user
  has_and_belongs_to_many :items
end
