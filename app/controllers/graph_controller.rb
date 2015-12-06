class GraphController < ApplicationController
  include GraphHelper

  def show
    @lat = Rails.cache.fetch('lat' + request.remote_ip.to_s)
    @lng = Rails.cache.fetch('lng' + request.remote_ip.to_s)
  end

  def load_local_deals
    num = params[:num]
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    deals = Deal.where("sqrt(power(#{lat}-latitude,2) + power(#{lng}-longitude,2)) < 0.0164").limit(num)
    hash = Gmaps4rails.build_markers(deals) do |deal, marker|
      marker.lat deal.latitude
      marker.lng deal.longitude
      window = deal.user.avatar.path ? createInfoWindowWithImage(deal) : createInfoWindowWithoutImage(deal)
      marker.infowindow window
    end
    respond_to do |format|
      format.json { render :json => hash, :layout => false}
    end
  end

  def save_user_location
    render :nothing => true
    Rails.cache.fetch('lat' + request.remote_ip.to_s, expires_in: 12.hours) {params[:lat]}
    Rails.cache.fetch('lng' + request.remote_ip.to_s, expires_in: 12.hours) {params[:lng]}
  end

end
