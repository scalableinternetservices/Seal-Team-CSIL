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
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Your information has been updated."
      redirect_to "/"
    else
      flash[:error] = "Something went wrong. Change this when specific validations are created."
      redirect_to "/users/#{:id}"
    end
  end

  def create
    puts "name is:\n"
    puts user_params[:street_address]
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Account has been created!"
      redirect_to "/"
    else
      flash[:error] = "Something went wrong in creating the account!"
      redirect_to '/signup'
    end
  end

  private

    def user_params
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
