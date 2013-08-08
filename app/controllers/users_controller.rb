class UsersController < ApplicationController
	before_filter :authenticate_user!

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
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params[:user].permit(:first_name, :last_name, :user_name, :email, :credit))
        redirect_to @user
      else
        render 'edit'
      end
  end

  def delete
    User.find(params[:id]).destroy
  end

end
