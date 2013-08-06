class ChangeStartDateFormatToDateTimeInListings < ActiveRecord::Migration
  def change
      change_column :listings, :start_date, :datetime
  end
end
