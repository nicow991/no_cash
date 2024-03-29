class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  def self.between(*user_ids)
    Chatroom.joins(:participants)
            .where(participants: { user_id: user_ids })
            .group('chatrooms.id')
            .having('COUNT(participants.id) = ?', user_ids.count)
            .first
  end
end
