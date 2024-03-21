class Offer < ApplicationRecord
  has_one :deal
  belongs_to :item
  belongs_to :user # this is not working for some reason. just use offer.item.user
  has_and_belongs_to_many :items
end
