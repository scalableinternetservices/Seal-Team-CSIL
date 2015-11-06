class GraphController < ApplicationController
  include GraphHelper

  def show
    @lat = Rails.cache.fetch('lat')
    @lng = Rails.cache.fetch('lng')
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

  def save_user_location
    render :nothing => true
    Rails.cache.fetch('lat') {params[:lat]}
    Rails.cache.fetch('lng') {params[:lng]}
  end

  def load_filter_deals
    distance_miles = params[ :distance ].to_f
    distance_meters = distance_miles  * 1609.34
    # location = Geocoder.search(params[ :street_address ] )
    # @lat = location[0].latitude
    # @lng = location[0].longitude
    lat = Rails.cache.fetch('lat').to_f
    lng = Rails.cache.fetch('lng').to_f

    deals = Deal.all
    hash = Gmaps4rails.build_markers(deals) do |deal, marker|
      if deal.latitude.present?
        if coordinate_distance( [lat, lng], [deal.latitude, deal.longitude] ) <= distance_meters
          if deal.deal_type == params[ :deal_type ].chop
            puts 'in deal_type'
            if deal.food_type == params[ :food_type ].chop
              puts 'in food_type'
              marker.lat deal.latitude
              marker.lng deal.longitude
              marker.infowindow createInfoWindow(deal)
            end
          end
        end
      end
    end
    puts hash.to_json
    respond_to do |format|
      format.json { render :json => hash, :layout => false}
    end
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
