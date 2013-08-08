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
		puts user.inspect
		@listing = Listing.find(params[:listing_id])

		if user.credit < @listing.credits_per_bid
			redirect_to "/users/edit"
			puts "no more credits" #change this to some failure response
		else
					@bids = Bid.all
					@bid = Bid.new
					@bid.user_id = params[:user_id]
					@bid.listing=@listing

					if @bid.save
						@listing.current_price += 1
						@listing.duration += @listing.time_per_bid
						@listing.save
						user.credit -= @listing.credits_per_bid
						user.save
					else
						raise #change this to some failure response
					end
		end
	end

end


