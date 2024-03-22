class AddContentToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :content, :text
  end
end
