class AddPhotoFieldToListings < ActiveRecord::Migration
  def self.up
    add_attachment :listings, :photo
  end

  def self.down
    remove_attachment :listings, :photo
  end
end
