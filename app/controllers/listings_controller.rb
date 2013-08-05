class ListingsController < ApplicationController
include ListingsHelper

    def new
        redirect_to "/" unless user_signed_in? && is_admin?
        @listing = Listing.new
    end

    def index

    end


end
