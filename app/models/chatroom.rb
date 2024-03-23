class Chatroom < ApplicationRecord
  has_many :messages
  has_many :participants
  has_many :users, through: :participants
end
