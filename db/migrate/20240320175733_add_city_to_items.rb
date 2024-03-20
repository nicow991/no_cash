class AddCityToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :city, :string
  end
end
