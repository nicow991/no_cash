class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.references :item, null: false, foreign_key: {to_table: :items}
      t.timestamps
    end
  end
end
