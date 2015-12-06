class UsersController < ApplicationController

  before_filter :authorize, :only => [:show, :edit, :update]
  skip_before_filter :verify_authenticity_token #get rid when turning in final!!!

  def new
    
  end

  def show
    @user = User.find_by(:id => params[:id])
    render "show"
  end

  def edit
    @user = User.find_by(:id => params[:id])
    render "edit"
  end

  def update
    user = User.find_by(:id => params[:id])
    user.update(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Your information has been updated."
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to "/users/#{user.id}/edit"
    end
  end

  def create
    user = User.new(formatted_user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Account has been created!"
      redirect_to "/"
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to '/signup'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :phone_number, :website, :avatar)
    end

    def formatted_user_params
      form_params = params.require(:user).permit(:name, :email, :password, :password_confirmation, :street_address, :city, :zip_code, :state, :phone_number, :website, :avatar)
      full_address = form_params[:street_address] + ' ' + form_params[:city] + ' ' + form_params[:zip_code] + ' ' + form_params[:state]
      form_params[:address] = full_address
      form_params.except!( 'street_address', 'city', 'zip_code', 'state' )
      form_params[:phone_number] = format_phone_number(form_params[:phone_number])
      form_params
    end

    def format_phone_number(phone_number)
      formatted = phone_number.tr('^0-9', '')
      formatted = formatted.length == 10 ? '1' + formatted : formatted
    end

end
