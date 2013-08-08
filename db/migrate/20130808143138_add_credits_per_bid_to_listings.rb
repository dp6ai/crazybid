class AddCreditsPerBidToListings < ActiveRecord::Migration
  def change
    add_column :listings, :credits_per_bid, :integer
  end
end
