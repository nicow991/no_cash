class CreatePreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :preferences do |t|
      t.references :item, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
