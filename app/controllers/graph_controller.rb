class GraphController < ApplicationController
  include GraphHelper

  def show
    @deals = Deal.all
    @hash = Gmaps4rails.build_markers(@deals) do |deal, marker|
      marker.lat deal.latitude
      marker.lng deal.longitude
      marker.infowindow createInfoWindow(deal)
    end
  end

end
