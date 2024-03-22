class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :user_reviewed, null: false, foreign_key: { to_table: :users }
      t.references :deal, null: false, foreign_key: true
      t.references :user_reviewer, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
