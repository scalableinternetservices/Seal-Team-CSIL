class UsersController < ApplicationController

  before_filter :authorize, :only => [:show, :edit, :update]

  def new
    # Render the login view
  end

  def show
    @user = User.find_by(:id => params[:id])
    render "show"
    # Render the user info page view
  end

  def edit
    @user = User.find_by(:id => params[:id])
    render "edit"
    # Allow a user to change the data about their account
  end

  def update
    user = User.find_by(:id => params[:id])
    user.update(user_params)
    if user.save!
      session[:user_id] = user.id
      flash[:success] = "Your information has been updated."
      redirect_to '/'
    else
      flash[:error] = "Something went wrong. Change this when specific validations are created."
      redirect_to '/user/:id'
    end
  end

  def create

    user = User.new(user_params)
    if user.save!
      session[:user_id] = user.id
      flash[:success] = "Account has been created!"
      redirect_to '/'
    else
      flash[:error] = "Something went wrong in creating the account!"
      redirect_to '/signup'
    end

  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :food_type, :address, :phone_number, :hours, :delivery, :website, :avatar)
    end

end
