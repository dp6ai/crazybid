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

		# if user.credit < @listing.credits_per_bid
		# 	redirect_to "/users/edit"
		# 	puts "no more credits" #change this to some failure response
		# else
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
						WebsocketRails[:bids].trigger 'new',{
								id: @listing.id, 
								current_price: @listing.current_price, 
								current_winner: @listing.bids.last.user.user_name,
								seconds_to_end: @listing.seconds_to_end

								}
							puts "XXXXXXXX #{@listing.seconds_to_end}"
					else
						raise #change this to some failure response
					end
		# end
	end

end


