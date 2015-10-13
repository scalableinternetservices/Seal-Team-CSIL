class DealsController < ApplicationController

  before_filter :authorize, :only => [:create, :new]

  def create
    deal = Deal.new(deals_params)
    deal.user_id = current_user.id
    if deal.save!
      flash[:success] = "Deal has been created!"
      redirect_to '/'
    else
      flash[:error] = "Something went wrong in creating the deal!"
      redirect_to '/signup'
    end
  end 

  def new
    @user = current_user
    render 'new'
  end

  private

    def deals_params
      params.require(:deal).permit(:food_name, :description, :address, :deal_type, :start_time, :end_time, :food_type)
    end

end
