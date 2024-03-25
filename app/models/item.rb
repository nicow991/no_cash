class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category

  # Specify the reverse associations for offers
  has_many :requested_offers, class_name: 'Offer', foreign_key: 'requested_item_id'
  has_many :offered_offers, class_name: 'Offer', foreign_key: 'offered_item_id'
  has_many :offered_items, through: :offered_offers, source: :requested_item


  validates :name, :description, :address, presence: true
  has_many_attached :photos
  has_many :preferences

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [:name, :description, :address],
    using: {
      tsearch: { prefix: true }
    }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  scope :by_category, ->(category_id) { where(category_id: category_id) }
end
