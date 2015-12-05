class TimelineController < ApplicationController

  def show
    @lat = Rails.cache.fetch('lat').to_f
    @lng = Rails.cache.fetch('lng').to_f
    @distance_miles = 1.0
    # @deals_within_proximity = Deal.where("sqrt(power(#{@lat}-latitude,2) + power(#{@lng}-longitude,2)) < #{0.0164 * @distance_miles}").paginate(:page => params[:page], :per_page => 10)
    @deals_within_proximity = Deal.where("sqrt(power(#{@lat}-latitude,2) + power(#{@lng}-longitude,2)) < #{0.0164 * @distance_miles}")

    render 'show'
  end

  def load_deals
  	@distance_miles = params[ :distance_from_address ].to_f()

    if params[ :street_address ].present?
    	location = Geocoder.search( params[ :street_address ] )
    elsif params[ :lat_lng ].present?
      location = Geocoder.search( params[ :lat_lng ] )
    else
      location = Geocoder.search( Rails.cache.fetch('lat') + ',' + Rails.cache.fetch('lng') )
    end

    @lat = location[0].latitude
    @lng = location[0].longitude
    # @deals_within_proximity = Deal.where("sqrt(power(#{@lat}-latitude,2) + power(#{@lng}-longitude,2)) < #{0.0164 * @distance_miles} AND (#{params[:food_type] == 'Any'} OR food_type='#{params[:food_type].to_s}')").paginate(:page => params[:page], :per_page => 10)
    @deals_within_proximity = Deal.where("sqrt(power(#{@lat}-latitude,2) + power(#{@lng}-longitude,2)) < #{0.0164 * @distance_miles} AND (#{params[:food_type] == 'Any'} OR food_type='#{params[:food_type].to_s}')")
    
  	render 'show'
  end

end

