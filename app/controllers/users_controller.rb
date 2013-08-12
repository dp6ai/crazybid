class UsersController < ApplicationController
  include ApplicationHelper #this is to get the is_admin method
	before_filter :authenticate_user!
  before_filter :redirect_unless_admin


  def show
      @user = User.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @user.credit }
      end
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
