class DeleteInitialDurationFromListings < ActiveRecord::Migration
  def change
      remove_column :listings, :initial_duration  
  end
end

