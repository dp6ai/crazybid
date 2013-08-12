class RemoveDisabledFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :disabled, :boolean
  end
end
