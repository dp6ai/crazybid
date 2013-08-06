class ChangeTimePerBidToIntegerInListings < ActiveRecord::Migration
  def change
    change_column :listings, :time_per_bid, :integer
  end
end
