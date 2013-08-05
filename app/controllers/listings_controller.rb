class ListingsController < ApplicationController
include ListingsHelper

    def new
        redirect_to "/" unless user_signed_in? && is_admin?
        @listing = Listing.new
    end

    def index

    end

    def create
      Listing.create(params[:listing].permit(:title, :description, :starting_price, :rrp, :start_date, :time_per_bid, :initial_duration))
      redirect_to "/"
    end


end
