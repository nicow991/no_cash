class AddRequestedItemToOffers < ActiveRecord::Migration[7.1]
  def change
    add_reference :offers, :requested_item, foreign_key: { to_table: :items }
  end
end
