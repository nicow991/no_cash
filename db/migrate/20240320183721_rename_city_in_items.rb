class RenameCityInItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :items, :city, :address
  end
end
