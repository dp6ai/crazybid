module ListingsHelper

  def is_admin?
    current_user.admin==true
  end
end
