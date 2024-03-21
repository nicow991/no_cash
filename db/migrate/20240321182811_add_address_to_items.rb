class AddAddressToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :address, :string
  end
end
