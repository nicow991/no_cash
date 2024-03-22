class AddOfferedItemToOffers < ActiveRecord::Migration[7.1]
  def change
    add_reference :offers, :offered_item, foreign_key: { to_table: :items }
  end
end
