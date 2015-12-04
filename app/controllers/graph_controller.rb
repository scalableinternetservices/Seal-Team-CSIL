class GraphController < ApplicationController
  include GraphHelper

  def show
    @lat = Rails.cache.fetch('lat')
    @lng = Rails.cache.fetch('lng')
  end

  def load_local_deals
    num = params[:num]
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    deals = Deal.where("sqrt(power(#{lat}-latitude,2) + power(#{lng}-longitude,2)) < 0.0164").limit(num)
    hash = Gmaps4rails.build_markers(deals) do |deal, marker|

      marker.lat deal.latitude
      marker.lng deal.longitude
      imageURL = deal.user.avatar.path ? deal.user.avatar : "/assets/NoImage.png"
      marker.infowindow createInfoWindow(deal, imageURL)

    end
    respond_to do |format|
      format.json { render :json => hash, :layout => false}
    end
  end

  def save_user_location
    render :nothing => true
    Rails.cache.fetch('lat') {params[:lat]}
    Rails.cache.fetch('lng') {params[:lng]}
  end

end
