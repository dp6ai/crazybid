class ListingsController < ApplicationController
#before_filter :authenticate_user!

    def index
    	@listings = Listing.all
    end

    def new
        redirect_to "/" unless user_signed_in? && current_user.is_admin?
    end


end
