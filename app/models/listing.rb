class Listing < ActiveRecord::Base
  before_save do |listing| 
    listing.start_date = Time.now
    listing.default_end_date = Time.now + 86400 
    listing.current_price = listing.starting_price
    listing.time_left = 86400
  end

end
