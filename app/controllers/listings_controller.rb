class ListingsController < ApplicationController
    #before_filter :authenticate_user!

    def index
    	@listings = Listing.all
    end

    include ListingsHelper


    def new
        redirect_to "/" unless user_signed_in? && is_admin?
        @listing = Listing.new
    end

    def create
      Listing.create(params[:listing].permit(:title, :description, :starting_price, :rrp, :start_date, :time_per_bid, :initial_duration))
      redirect_to "/"
    end


end