class BidsController < ApplicationController


	def index
		@bids = Bid.all
	end

	def new
		@bid = Bid.new
		redirect_to '/'
	end
	
	def create
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @bid }
		end
		@bids = Bid.all
		@listing = Listing.find(params[:listing_id])
		@bid = Bid.new
		@bid.user_id = params[:user_id]
		@bid.listing=@listing
		if @bid.save
			@listing.current_price += 1
			@listing.duration += @listing.time_per_bid
			@listing.save
		else
			raise
		end

	end

end
