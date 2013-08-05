class DeleteTimeFromListing < ActiveRecord::Migration
  def change
    remove_column :listings, :time
  end
end
