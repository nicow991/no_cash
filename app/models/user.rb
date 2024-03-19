class User < ApplicationRecord
  has_many :messages
  has_many :deals
  has_many :chatrooms, through: :deals
  has_many :items, dependent: :destroy
  has_many :reviews
  has_many :offers, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
