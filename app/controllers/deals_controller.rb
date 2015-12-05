class DealsController < ApplicationController

  #before_filter :authorize, :only => [:create, :new, :show, :edit, :update, :destroy, :update_view_count]
  skip_before_filter :verify_authenticity_token #Get rid of this when turning in!!!!
  def create
    deal = Deal.new(formatted_deal_params, views: 0, shares: 0, purchases: 0)
    deal.user_id = current_user.id
    if deal.save
    flash[:success] = "Deal has been created!"
    redirect_to "/users/#{current_user.id}/deals"
    else
      flash[:error] = deal.errors.full_messages.to_sentence
      redirect_to "/users/#{current_user.id}/create_deal"
    end
  end 

  def new
    @user = User.find_by(id: params[:id])
    render 'new'
  end

  def show
    @user = User.find_by(id: params[:id])
    @deals = @user.deals.paginate(:page => params[:page], :per_page => 10)
    @page = params[:page]
    render 'show'
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @deal = Deal.find_by(id: params[:deal_id])
    render 'edit'
  end

  def update
    deal = Deal.find_by(:id => params[:deal_id])
    deal.update(deal_params)
    deal.save!
    flash[:success] = "Deal has been updated!"
    redirect_to "/users/#{current_user.id}/deals"
  rescue
    flash[:error] = deal.errors.full_messages.to_sentence
    redirect_to "/users/#{current_user.id}/deals/#{deal.id}"
  end

  def destroy_all
    if(User.find_by(id: params[:user_id]).deals.destroy_all)
      flash[:success] = "All deals have been deleted!"
    else
      flash[:error] = "Something went wrong in deleting all deals!"
    end
    redirect_to "/users/#{current_user.id}/deals"
  end

  def destroy
    deal = Deal.find_by(:id => params[:deal_id])
    deal.destroy!
    flash[:success] = "Your deal has been deleted."
    redirect_to "/users/#{params[:user_id]}/deals"
    rescue
      flash[:error] = "Something went wrong when deleting the deal."
      redirect_to "/users/#{params[:user_id]}/deals"
  end

  def update_view_count
    render :nothing => true
    deal = Deal.find_by(:id => params[:deal_id])
    deal.update!(views: deal.views + 1)
  end

  private

    def deal_params
      params.require( :deal ).permit( :food_name, :description, :address, :deal_type, :start_time, :end_time, :food_type, :avatar )
    end

    def formatted_deal_params
      form_params = params.require(:deal).permit(:food_name, :street_address, :city, :zip_code, :state, :deal_type, :start_time, :end_time, :food_type, :avatar)
      full_address = form_params[ :street_address ] + ' ' + form_params[ :city ] + ' ' + form_params[ :zip_code ] + ' ' + form_params[ :state ]
      form_params[ :address ] = full_address
      form_params.except!( 'street_address', 'city', 'zip_code', 'state' )
      form_params
    end

end
