module ListingsHelper

  def is_admin?
    current_user && current_user.admin==true
  end

  def listing_auction_end(item)
  	(item.start_date + item.duration).strftime(format='%H:%M:%S') 
  end
end
