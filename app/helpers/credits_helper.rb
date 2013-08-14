module CreditsHelper
  def get_credits(amount)
    credit_value = {
      500 => 50,
      900 => 100,
      4000 => 500
    }
    credit_value[amount]
  end

  def valid_credit_payment?(amount)
    !(get_credits(amount) == nil)
  end


  def add_credits_for_payment_amount(amount)
    current_user.credit += get_credits(amount)
    current_user.save
  end
end
