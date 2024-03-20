class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :name, :description, :address, presence: true
  has_many_attached :photos
  has_many :preferences

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
  against: [ :name, :description, :address],
  using: {
    tsearch: { prefix: true }
  }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
