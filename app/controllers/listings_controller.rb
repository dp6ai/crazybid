class ListingsController < ApplicationController
    #before_filter :authenticate_user!
    before_filter :redirect_to_homepage_unless_admin, only: [:new, :create]

    def index
    	@listings = Listing.all
    end

    include ListingsHelper


    def new
        @listing = Listing.new
    end

    def create
        @listing = Listing.create(params[:listing].permit(:title, :description, :starting_price, :rrp, :time_per_bid))

        if @listing.save  
            redirect_to "/"
        else
            render "new"
        end

    end

    def show
        @listing = Listing.find(params[:id])
    end

    private

    def redirect_to_homepage_unless_admin
        redirect_to "/" unless user_signed_in? && is_admin?
    end


end