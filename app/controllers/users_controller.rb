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
    user.save!
    session[:user_id] = user.id
    flash[:success] = "Your information has been updated."
    redirect_to show_user_path
    rescue
      flash[:error] = "Something went wrong while updating your account."
      redirect_to edit_user_path
  end

  def create
    user = User.new(user_params)
    user.save!
    session[:user_id] = user.id
    flash[:success] = "Account has been created!"
    redirect_to show_user_path
    rescue
      flash[:error] = "Something went wrong in creating the account!"
      redirect_to new_user_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :phone_number, :website, :avatar)
    end

    def formatted_user_params
      form_params = params.require(:user).permit(:name, :email, :password, :password_confirmation, :street_address, :city, :zip_code, :state, :phone_number, :website, :avatar)
      full_address = form_params[:street_address] + ' ' + form_params[:city] + ' ' + form_params[:zip_code] + ' ' + form_params[:state]
      form_params.except!('street_address', 'city', 'zip_code', 'state')
      form_params[:address] = full_address
      form_params[:phone_number] = format_phone_number(form_params[:phone_number])
      form_params  
    end

    def format_phone_number(phone_number)
      formatted = phone_number.tr('^0-9', '')
      formatted = formatted.length == 10 ? '1' + formatted : formatted
    end

end
