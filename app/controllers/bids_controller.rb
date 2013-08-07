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
		@bid.save
	end

end
