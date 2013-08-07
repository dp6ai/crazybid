class Listing < ActiveRecord::Base
  validates_presence_of :title, :description, :starting_price, :rrp, :time_per_bid
  validates :photo, :attachment_presence => true
  validates_numericality_of :starting_price, :rrp, :time_per_bid, greater_than: 0
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  before_save do |listing| 
    listing.start_date = Time.now
    listing.default_end_date = Time.now + 86400 
    listing.current_price = listing.starting_price
    listing.duration = 86400
  end

  has_many :bids
end

