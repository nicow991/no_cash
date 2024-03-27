class AddHiddenToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :hidden, :boolean, default: false
  end
end
