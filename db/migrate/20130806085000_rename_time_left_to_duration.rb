class RenameTimeLeftToDuration < ActiveRecord::Migration
  def change
    rename_column :listings, :time_left, :duration
  end
end
