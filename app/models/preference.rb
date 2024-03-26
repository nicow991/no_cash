class Preference < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :category, uniqueness: { scope: :user }
end
