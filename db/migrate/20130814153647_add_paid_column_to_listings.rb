class AddPaidColumnToListings < ActiveRecord::Migration
  def change
    add_column :listings, :paid, :boolean
  end
end
