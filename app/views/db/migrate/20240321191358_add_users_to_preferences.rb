class AddUsersToPreferences < ActiveRecord::Migration[7.1]
  def change
    add_reference :preferences, :user, foreign_key: true
  end
end
