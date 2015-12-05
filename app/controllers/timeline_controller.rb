class TimelineController < ApplicationController
  include TimelineHelper

  def show
    lat = get_lat
    lng = get_lng
    distance_miles = 1.0
    # @deals_within_proximity = Deal.where("sqrt(power(#{@lat}-latitude,2) + power(#{@lng}-longitude,2)) < #{0.0164 * @distance_miles}").paginate(:page => params[:page], :per_page => 10)
    @deals_within_proximity = Deal.where("sqrt(power(#{lat}-latitude,2) + power(#{lng}-longitude,2)) < #{0.0164 * distance_miles}")
    @address_data = get_address_data
    render 'show'
  end

  def load_deals
  	distance_miles = params[ :distance_from_address ].to_f()

    if params[ :street_address ].present?
    	location = Geocoder.search( params[ :street_address ] )
    elsif params[ :lat_lng ].present?
      location = Geocoder.search( params[ :lat_lng ] )
    else
      location = Geocoder.search( Rails.cache.fetch('lat') + ',' + Rails.cache.fetch('lng') )
    end

    lat = location[0].latitude
    lng = location[0].longitude
    # @deals_within_proximity = Deal.where("sqrt(power(#{@lat}-latitude,2) + power(#{@lng}-longitude,2)) < #{0.0164 * @distance_miles} AND (#{params[:food_type] == 'Any'} OR food_type='#{params[:food_type].to_s}')").paginate(:page => params[:page], :per_page => 10)
    @deals_within_proximity = Deal.where("sqrt(power(#{@lat}-latitude,2) + power(#{@lng}-longitude,2)) < #{0.0164 * distance_miles} AND (#{params[:food_type] == 'Any'} OR food_type='#{params[:food_type].to_s}')")
    @address_data = get_address_data
  	render 'show'
  end

  private

  def get_address_data
    lat_lng_present = Rails.cache.fetch( 'lat' ).present? && Rails.cache.fetch( 'lng' ).present?
    address_valid = false
    if lat_lng_present
      geocoder_result = Geocoder.search( Rails.cache.fetch( 'lat' ) + ',' + Rails.cache.fetch( 'lng' ) )
      address_valid = geocoder_result.blank? ? false : true
    end
    address_data = address_valid ? geocoder_result[ 0 ].data["formatted_address"] : Geocoder.search( get_lat + ',' + get_lng )[ 0 ].data["formatted_address"]
  end

end

