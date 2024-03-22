class DropItemsOffers < ActiveRecord::Migration[7.1]
  def change
    drop_table :items_offers
  end
end
