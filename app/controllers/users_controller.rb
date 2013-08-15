class UsersController < ApplicationController
  include ApplicationHelper #this is to get the is_admin method
	before_filter :authenticate_user!
  before_filter :redirect_unless_admin, except: [:profile, :add_payment]

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user.credit }
    end
  end

  def profile

    # @current_winner = current_winner
    @won_listings = Listing.all.where(" status = 'r'")
    @won_listings = @won_listings.select{|l| l.current_winner == current_user.user_name}  
    
  end

  def add_payment
      @amount = params[:amount].to_i
      @listing = Listing.find(params[:listing_id])

      raise "Incorrect" if @listing.current_price != @amount 

      customer = Stripe::Customer.create(
        :email => 'example@stripe.com',
        :card  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'CrazyBid Auction Payment',
        :currency    => 'gbp'
      )
      
      @listing.paid = true
      @listing.save

      redirect_to '/users/profile'
        
      flash[:notice] = "You have successfully paid"
        rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_credit_path
  end

  def new
  	@user = User.new
  end

  def edit
    # redirect_to '/' unless is_admin?
  	@user = User.find(params[:id])
  end

  def update
    # redirect_to '/' unless is_admin?
    @user = User.find(params[:id])
    if @user.update(params[:user].permit(:first_name, :last_name, :user_name, :email, :credit, :disabled))
        redirect_to @user
      else
        render 'edit'
      end
  end

  def delete
    # redirect_to '/' unless is_admin?
    User.find(params[:id]).destroy
  end

end
