class AddInitialDurationToListing < ActiveRecord::Migration
  def change
    add_column :listings, :initial_duration, :time
  end
end
