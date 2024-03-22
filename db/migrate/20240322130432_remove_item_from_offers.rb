class RemoveItemFromOffers < ActiveRecord::Migration[7.1]
  def change
    remove_reference :offers, :item
  end
end
