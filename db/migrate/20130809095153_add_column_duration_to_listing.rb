class AddColumnDurationToListing < ActiveRecord::Migration
 def change
    add_column :listings, :duration, :integer
  end
end

