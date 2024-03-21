class AddUserToDeals < ActiveRecord::Migration[7.1]
  def change
    add_reference :deals, :user, foreign_key: true
    change_column_default :deals, :status, from: nil, to: 'accepted'
  end
end
