class GraphController < ApplicationController

  def show
    @deals = Deal.all
    @hash = Gmaps4rails.build_markers(@deals) do |deal, marker|
      marker.lat deal.latitude
      marker.lng deal.longitude
      marker.infowindow "Deal: " + deal.food_name
    end
  end

end
