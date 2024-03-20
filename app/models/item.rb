class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :name, :description, presence: true
  has_many_attached :photos
  has_many :preferences

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description ],
    using: {
    tsearch: { prefix: true }
    }
end
