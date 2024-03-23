class AddStatusToOffers < ActiveRecord::Migration[7.1]
  def change
    add_column :offers, :status, :string, default: "pending"
  end
end
