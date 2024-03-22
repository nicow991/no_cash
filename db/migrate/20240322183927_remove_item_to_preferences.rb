class RemoveItemToPreferences < ActiveRecord::Migration[7.1]
  remove_reference :preferences, :item, foreign_key: true
  add_reference :preferences, :user, foreign_key: true
end
