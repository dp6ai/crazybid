module ApplicationHelper

 def is_admin?
    current_user && current_user.admin==true
  end

  def redirect_unless_admin
    redirect_to '/' unless is_admin?
  end

end
