class AdminController < ApplicationController
    before_filter :authenticate_user!
    before_filter :redirect_to_homepage_unless_admin, only: [:new, :create]


    def index
    	@listings = Listing.all
    	@users = User.all
    end

    def show
        @listing = Listing.find(params[:id])
    end

    private

    def redirect_to_homepage_unless_admin
        redirect_to "/" unless user_signed_in? && is_admin?
    end


end