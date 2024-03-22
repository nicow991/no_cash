class CreateDeals < ActiveRecord::Migration[7.1]
  def change
    create_table :deals do |t|
      t.references :offer, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
