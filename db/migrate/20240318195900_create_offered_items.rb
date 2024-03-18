class CreateOfferedItems < ActiveRecord::Migration[7.1]
  def change
    create_table :offered_items do |t|
      t.references :offer, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
