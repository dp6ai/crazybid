module BidsHelper

	def item_last_bid_user(item)
	  if item.bids.empty?
	    "This could be you!"
	  else
	    item.bids.last.user.user_name
	  end
	end

end
