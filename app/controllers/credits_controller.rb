class CreditsController < ApplicationController
  before_filter :authenticate_user!

  include CreditsHelper


  def new

  end

  def create
      @amount = params[:amount].to_i
      
      raise "Invalid amount" unless valid_credit_payment?(@amount)

      # puts "********** #{@amount.inspect}"
      customer = Stripe::Customer.create(
        :email => 'example@stripe.com',
        :card  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'CrazyBid Credit Add-on',
        :currency    => 'gbp'
      )

      add_credits_for_payment_amount(@amount)
      redirect_to '/'
      
      flash[:notice] = "You have successfully added #{get_credits(@amount)}"
        rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_credit_path
  end

end
