class DealsController < ApplicationController

  before_filter :authorize, :only => [:create, :new, :show, :edit, :update, :destroy]

  def create
    deal = Deal.new(deals_params)
    deal.user_id = current_user.id
    if deal.save!
      flash[:success] = "Deal has been created!"
      redirect_to "/users/#{current_user.id}/deals"
    else
      flash[:error] = "Something went wrong in creating the deal!"
      redirect_to "/users/#{current_user.id}/deals"
    end
  end 

  def new
    @user = User.find_by(id: params[:id])
    render 'new'
  end

  def show
    @user = User.find_by(id: params[:id])
    @deals = @user.deals
    render 'show'
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @deal = Deal.find_by(id: params[:deal_id])
    render 'edit'
  end

  def update
    deal = Deal.find_by(:id => params[:deal_id])
    deal.update(deals_params)
    if deal.save!
      flash[:success] = "Your deal has been updated."
      redirect_to "/users/#{params[:user_id]}/deals"
    else
      flash[:error] = "Something went wrong. Change this when specific validations are created."
      redirect_to "/users/#{params[:user_id]}/deals"
    end
  end

  def destroy
    deal = Deal.find_by(:id => params[:deal_id])
    if deal.destroy!
      flash[:success] = "Your deal has been destroyed."
      redirect_to "/users/#{params[:user_id]}/deals"
    else
      flash[:error] = "Something went wrong. Change this when specific validations are created."
      redirect_to "/users/#{params[:user_id]}/deals"
    end
  end

  private

    def deals_params
      params.require(:deal).permit(:food_name, :description, :address, :deal_type, :start_time, :end_time, :food_type)
    end

end
