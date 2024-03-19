class AddContentToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :content, :string
  end
end
