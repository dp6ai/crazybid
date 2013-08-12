class AddStatusToListing < ActiveRecord::Migration
  def change
  	add_column :listings, :status, :string
  end
end
