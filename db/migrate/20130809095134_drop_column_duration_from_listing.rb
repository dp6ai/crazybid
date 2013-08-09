class DropColumnDurationFromListing < ActiveRecord::Migration
	def change
    remove_column :listings, :duration
  end
end
