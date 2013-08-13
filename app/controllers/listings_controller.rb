class ListingsController < ApplicationController
    #before_filter :authenticate_user!
    before_filter :redirect_to_homepage_unless_admin, only: [:new, :create, :update]

    def index
      @listings = Listing.all.order("id DESC")
      @active_listings = Listing.where(active: true)
      @recent_listings = Listing.where(active: true)
      @coming_listings = Listing.where(active: true)
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
      if @listing.update(params[:listing].permit(:title, :description, :starting_price, :rrp, :time_per_bid, :photo, :active, :credits_per_bid, :duration))
        redirect_to @listing
      else
        render 'edit'
      end
    end

    def create
      # redirect_to_homepage_unless_admin

      duration_human_modified = DateTime.new(
        params[:listing]["duration_human(1i)"].to_i, 
        params[:listing]["duration_human(2i)"].to_i, 
        params[:listing]["duration_human(3i)"].to_i, 
        params[:listing]["duration_human(4i)"].to_i, 
        params[:listing]["duration_human(5i)"].to_i
        )

      # redirect_to_homepage_unless_admin
      params[:listing].delete("duration_human(1i)")
      params[:listing].delete("duration_human(2i)")
      params[:listing].delete("duration_human(3i)")
      params[:listing].delete("duration_human(4i)")
      params[:listing].delete("duration_human(5i)")

      redirect_to_homepage_unless_admin
      converted_duration = duration_human_modified.to_time - (Time.now).to_i

      params[:listing][:duration] = converted_duration
      @listing = Listing.new(params[:listing].permit(:title, :description, :starting_price, :rrp, :time_per_bid, :photo, :active, :credits_per_bid, :duration))

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
      render json: Listing.where(active: true).limit(6), :only => [:id, :current_price], :methods => [:seconds_to_end, :current_winner]
    end

    private

    def redirect_to_homepage_unless_admin
      redirect_to "/" unless user_signed_in? && is_admin?
    end

end
