class RemoveAddressToItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :address, :string
  end
end
