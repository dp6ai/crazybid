class AddDefaultEndDateToListings < ActiveRecord::Migration
  def change
      add_column :listings, :default_end_date, :integer  
  end
end
