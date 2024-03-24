class Deal < ApplicationRecord
  belongs_to :offer
  has_many :reviews
  delegate :requested_item, to: :offer
  delegate :offered_item, to: :offer
  delegate :user_requested, to: :offer
  delegate :user_offerer, to: :offer
end
