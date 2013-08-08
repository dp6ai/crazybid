class ListingsController < ApplicationController
    #before_filter :authenticate_user!
    before_filter :redirect_to_homepage_unless_admin, only: [:new, :create]


    def index
        #redirect_to '/admin' if is_admin?
      @listings = Listing.all
      @active_listings = Listing.where(active: true)
      @users = User.all
    end

    include ListingsHelper


    def new
        @listing = Listing.new
    end
    
    def edit
      redirect_to_homepage_unless_admin
      @listing = Listing.find(params[:id])
    end

    def update
      @listing = Listing.find(params[:id])
      if @listing.update(params[:listing].permit(:title, :description, :starting_price, :rrp, :time_per_bid, :photo, :active  ))
        redirect_to @listing
      else
        render 'edit'
      end
    end

    def create
        redirect_to_homepage_unless_admin
        @listing = Listing.create(params[:listing].permit(:title, :description, :starting_price, :rrp, :time_per_bid, :photo, :active))

        if @listing.save  
            redirect_to "/"
        else
            render "new"
        end

    end

    def show
        @listing = Listing.find(params[:id])
    end


    def active
        render json: Listing.where(active: true).limit(6), :only => [:id, :current_price], :methods => [:seconds_to_end]
    end

    private

    def redirect_to_homepage_unless_admin
        redirect_to "/" unless user_signed_in? && is_admin?
    end


end
