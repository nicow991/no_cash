class AddUserToOffers < ActiveRecord::Migration[7.1]
  def change
    add_reference :offers, :user, null: false, foreign_key: true
  end
end
