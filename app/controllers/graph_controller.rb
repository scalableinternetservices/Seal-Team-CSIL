class GraphController < ApplicationController

  def show
    @users = User.all
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow "Restaurant Name: " + user.name + "\n" + "Food Type: " + user.food_type
    end
  end

end
