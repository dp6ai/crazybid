module ListingsHelper

  def is_admin?
    current_user && current_user.admin==true
  end

  def listing_auction_end(item)
  	(item.start_date + item.duration).strftime(format='%H:%M:%S') 
  end
  
  def paid_status(listing)
    if listing.paid
  	   "paid"
    else
  	   "unpaid"
    end
  end

  def listing_status(listing)
    case listing.status
    when "a" then "Active"
    when "c" then "Coming Soon"
    when "r" then "Expired"
    end
  end


end
