module GraphHelper

  def createInfoWindowWithImage(deal)
    "<img src='#{deal.user.avatar}' style = 'max-height: 150px; max-width: 150px;' />" + createBaseInfoWindow(deal)
  end

  def createInfoWindowWithoutImage(deal)
    createBaseInfoWindow(deal)
  end

  def createBaseInfoWindow(deal)
    "
    <div><b>Restaurant: #{deal.user.name} </div>
    </br>
    <div> Food: #{deal.food_name} </div>
    <div> Type Of Food: #{deal.food_type} </div>
    <div> Deal Type: #{deal.deal_type} </div>
    </br>
    <div> Start Time: #{deal.start_time.strftime("%m-%d-%Y at %I:%M%p")} </div>
    <div> End Time: #{deal.end_time.strftime("%m-%d-%Y at %I:%M%p")}</div>
    </br>
    <div> Website: #{deal.user.website} </div>
    <div hidden> deal_id: #{deal.id}</div>
    "
  end

end
