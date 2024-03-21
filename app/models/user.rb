class User < ApplicationRecord
  has_many :messages
  has_many :chatrooms
  has_many :items, dependent: :destroy
  has_many :my_offers, through: :items, dependent: :destroy, source: "offer"
  has_many :received_offers, through: :items, dependent: :destroy, source: "offers"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
