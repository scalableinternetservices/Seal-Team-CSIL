module GraphHelper

  def createInfoWindow(deal)
    "<div><b>#{deal.user.name}</div>
    </br>

    <div> <i> #{deal.name} </i> </div>
    <div> #{deal.food_type} </div>
    <div> #{deal.deal_type} </div>
    <div>Start Time: #{deal.start_time} </div>
    <div>End Time: #{deal.end_time}</div>
    <div> <a href=#{deal.user.website}> Website: </div>
    <div hidden> deal_id: #{deal.id}</div>"
  end
end
