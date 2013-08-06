class Listing < ActiveRecord::Base
  validates_presence_of :title, :description, :starting_price, :rrp, :time_per_bid
  validates_numericality_of :starting_price, :rrp, :time_per_bid, greater_than: 0

  before_save do |listing| 
    listing.start_date = Time.now
    listing.default_end_date = Time.now + 86400 
    listing.current_price = listing.starting_price
    listing.duration = 86400
  end



end

