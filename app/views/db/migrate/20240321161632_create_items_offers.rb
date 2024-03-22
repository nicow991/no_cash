class CreateItemsOffers< ActiveRecord::Migration[7.1]
  def change
    create_table :items_offers do |t|
      t.references :item, null: false, foreign_key: true
      t.references :offer, null: false, foreign_key: true
      t.timestamps
    end
  end
end
