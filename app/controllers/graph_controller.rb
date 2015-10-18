class GraphController < ApplicationController
  include GraphHelper

  def show

  end

  def load_local_deals
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    deals = Deal.all
    hash = Gmaps4rails.build_markers(deals) do |deal, marker|
      #TODO Add validation to deals so that they must have lat and lng, then get rid of this check
      if deal.latitude.present?
        if coordinate_distance([lat,lng],[deal.latitude, deal.longitude]) < 8000
          marker.lat deal.latitude
          marker.lng deal.longitude
          marker.infowindow createInfoWindow(deal)
        end
      end
    end
    puts hash.to_json
    respond_to do |format|
      format.json { render :json => hash, :layout => false}
    end
    #render hash, :layout => false
  end

  private

  def coordinate_distance(loc1, loc2)
    puts loc1
    puts loc2
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    dlat_rad = (loc2[0] - loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1] - loc1[1]) * rad_per_deg

    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rm * c # Delta in meters
  end
end
