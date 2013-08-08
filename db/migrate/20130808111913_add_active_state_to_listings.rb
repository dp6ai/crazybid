class AddActiveStateToListings < ActiveRecord::Migration
  def change
    add_column :listings, :active, :boolean
  end
end
