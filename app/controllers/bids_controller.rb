class BidsController < ApplicationController

	def index
	@bids = Bid.all
	end

	def new
	# @bid = Bid.new
	# redirect_to '/'
	end

	def create
		respond_to do |format|
		format.html # new.html.erb
		format.json { render json: @bid }
		end

		user = User.find(params[:user_id])
		@listing = Listing.find(params[:listing_id])

		@bids = Bid.all
		
		unless (@listing.start_date + @listing.duration) <= Time.now || current_user.credit < @listing.credits_per_bid		#i.e. don't execute if listing has ended
				@bid = Bid.new
				@bid.user_id = params[:user_id]
				@bid.listing=@listing

				if @bid.save
					@listing.current_price += 1
					@listing.duration += @listing.time_per_bid
					@listing.save
					user.credit -= @listing.credits_per_bid
					user.save
					
					websocket_helper[:bids].trigger 'new',{
						id: @listing.id, 
						current_price: @listing.current_price, 
						current_winner: @listing.bids.last.user.user_name,
						seconds_to_end: @listing.seconds_to_end,
						user_credits: user.credit
					}
				else
					raise #change this to some failure response
				end

		end

	end

end
