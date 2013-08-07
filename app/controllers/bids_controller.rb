class BidsController < ApplicationController


	def index
		@bids = Bid.all
	end

	def new
		@bid = Bid.new
		redirect_to '/'
	end
	
	def create
		@listing = Listing.find(params[:listing_id])
		@bid = Bid.new
		@bid.user_id = params[:user_id]
		@bid.listing=@listing
		@bid.save
	end

end
