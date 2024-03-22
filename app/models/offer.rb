class Offer < ApplicationRecord
  has_one :deal

  # Replace the generic `belongs_to :item` with specific associations
  belongs_to :requested_item, class_name: 'Item', foreign_key: 'requested_item_id'
  belongs_to :offered_item, class_name: 'Item', foreign_key: 'offered_item_id'
end
