class User < ApplicationRecord
  has_many :messages
  has_many :participants
  has_many :chatrooms, through: :participants
  has_many :reviews
  has_many :preferences, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :offered_offers, through: :items, dependent: :destroy, source: :offered_offers
  has_many :received_offers, through: :items, dependent: :destroy, source: :requested_offers
  has_many :offered_deals, through: :offered_offers, source: :deal
  has_many :received_deals, through: :received_offers, source: :deal
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo

  def deals
    offered_deals.or(Item.where(id: received_deals))
  end


end
