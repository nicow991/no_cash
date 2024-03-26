class Offer < ApplicationRecord
  has_one :deal

  belongs_to :requested_item, class_name: 'Item', foreign_key: 'requested_item_id'
  belongs_to :offered_item, class_name: 'Item', foreign_key: 'offered_item_id'

  def user_requested
    requested_item.user
  end

  def user_offerer
    offered_item.user
  end

  def users
    [offered_item.user, requested_item.user]
  end

end
