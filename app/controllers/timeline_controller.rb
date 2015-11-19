class TimelineController < ApplicationController

  def show
    # Render timeline and pass all necessary info to the view.
    @deals_within_proximity = []
    @valid_deals_count = 0
    @lat = Rails.cache.fetch('lat').to_f
    @lng = Rails.cache.fetch('lng').to_f
    @distance_miles = 5.0
    distance_meters = @distance_miles * 1609.34
    Deal.all.each do |deal|
      if deal.latitude.present? and deal.longitude.present?
        if coordinate_distance([deal.latitude, deal.longitude],[@lat,@lng]) <= distance_meters
          @valid_deals_count+=1
          @deals_within_proximity.append(deal)
        end
      end
    end
    render 'show'
  end

  def load_deals
  	@distance_miles = params[ :distance_from_address ].to_f()
  	distance_meters = @distance_miles  * 1609.34
    @valid_deals_count = 0
    if params[ :street_address ].present?
    	location = Geocoder.search( params[ :street_address ] )
    elsif params[ :lat_lng ].present?
      location = Geocoder.search( params[ :lat_lng ] )
    else
      location = Geocoder.search( Rails.cache.fetch('lat') + ',' + Rails.cache.fetch('lng') )
    end

    @deals_within_proximity = []
    @lat = location[0].latitude
    @lng = location[0].longitude

  	Deal.all.each do |deal|
  		if coordinate_distance([deal.latitude, deal.longitude],[@lat,@lng]) <= distance_meters
        if deal.deal_type == params[:deal_type]
          if deal.food_type == params[:food_type]
            @valid_deals_count+=1
    			  @deals_within_proximity.append(deal)
          end
        end
  		end
  	end
  	render 'show'
  end

  def reset_deals
    @valid_deals_count = Deal.all.count
    @deals_within_proximity = Deal.all
    render 'show'
  end

  private

  def coordinate_distance(loc1, loc2)
    #puts loc1
    #puts loc2
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

