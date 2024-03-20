class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :name, :description, :city, presence: true
  has_many_attached :photos
  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
  against: [ :name, :description, :city],
  using: {
    tsearch: { prefix: true }
  }
  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_city?
end
