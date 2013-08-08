class Listing < ActiveRecord::Base
  validates_presence_of :title, :description, :starting_price, :rrp, :time_per_bid
  validates :photo, :attachment_presence => true
  validates_numericality_of :starting_price, :rrp, :time_per_bid, greater_than: 0
  has_attached_file :photo, 
                    :styles => { 
                        :square =>  ' -background white -compose Copy -gravity center -extent x300"',

        
                        :medium => "300x300>", 
                        :thumb => "100x100>" }, 
                    :default_url => "/images/:style/missing.png"
  before_create do |listing| 
    listing.start_date = Time.now
    listing.default_end_date = Time.now + 86400 
    listing.current_price = listing.starting_price
    listing.duration = 86400
  end

  has_many :bids

  def seconds_to_end
      (self.duration - (Time.now - self.start_date)).floor
  end

  def current_winner
    if self.bids.empty?
      ""
    else
      self.bids.last.user.user_name
    end
  end


end

