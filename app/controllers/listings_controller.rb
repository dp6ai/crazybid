class ListingsController < ApplicationController
    #before_filter :authenticate_user!
    before_filter :redirect_to_homepage_unless_admin, only: [:new, :create, :update]

    def index
      if is_admin?
          @listings = Listing.all(:order => "status ASC")
          @bids = Bid.order("created_at DESC").limit(10)
          @users = User.all
      else 
          @active_listings = Listing.where(status: "a")
          @recent_listings = Listing.where(status: "r")
          @coming_listings = Listing.where(status: "c")
      end
    end

    include ListingsHelper

    def new
        redirect_to_homepage_unless_admin
        @listing = Listing.new
    end
    
    def edit
      redirect_to_homepage_unless_admin
      @listing = Listing.find(params[:id])
    end

    def update
      redirect_to_homepage_unless_admin
      @listing = Listing.find(params[:id])
      
      duration_human_modified = DateTime.new(
        params[:listing]["duration_human(1i)"].to_i, 
        params[:listing]["duration_human(2i)"].to_i, 
        params[:listing]["duration_human(3i)"].to_i, 
        params[:listing]["duration_human(4i)"].to_i, 
        params[:listing]["duration_human(5i)"].to_i
        )

      params[:listing].delete("duration_human(1i)")
      params[:listing].delete("duration_human(2i)")
      params[:listing].delete("duration_human(3i)")
      params[:listing].delete("duration_human(4i)")
      params[:listing].delete("duration_human(5i)")

     
      converted_duration = duration_human_modified.to_time - (@listing.start_date).to_i

      params[:listing][:duration] = converted_duration

      if @listing.update(params[:listing].permit(:title, :description, :starting_price, :rrp, :time_per_bid, :photo, :active, :credits_per_bid, :duration, :status))
        redirect_to @listing
      else
        render 'edit'
      end
    end

    def create
       redirect_to_homepage_unless_admin

      duration_human_modified = DateTime.new(
        params[:listing]["duration_human(1i)"].to_i, 
        params[:listing]["duration_human(2i)"].to_i, 
        params[:listing]["duration_human(3i)"].to_i, 
        params[:listing]["duration_human(4i)"].to_i, 
        params[:listing]["duration_human(5i)"].to_i
        )

      params[:listing].delete("duration_human(1i)")
      params[:listing].delete("duration_human(2i)")
      params[:listing].delete("duration_human(3i)")
      params[:listing].delete("duration_human(4i)")
      params[:listing].delete("duration_human(5i)")

     
      converted_duration = duration_human_modified.to_time - (Time.now).to_i

      params[:listing][:duration] = converted_duration
      @listing = Listing.new(params[:listing].permit(:title, :description, :starting_price, :rrp, :time_per_bid, :photo, :active, :credits_per_bid, :duration, :status))
      @listing.paid = false
      if @listing.save  
        redirect_to "/"
      else
        render "new"
      end
    end

    def destroy
      redirect_to_homepage_unless_admin
      @listing = Listing.find(params[:id])
      title = @listing.title
      if @listing.destroy
        redirect_to "/" 
        flash[:notice] = "You have deleted item #{title}" 
      end
    end

    def show
      @listing = Listing.find(params[:id])
      @bids = @listing.bids.order("created_at DESC") if is_admin?
    end

    def active
      render json: Listing.where(active: true).limit(6), :only => [:id, :current_price], :methods => [:seconds_to_end, :current_winner]
    end

    private

    def redirect_to_homepage_unless_admin
      redirect_to "/" unless user_signed_in? && is_admin?
    end

end
