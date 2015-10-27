module GraphHelper

  def createInfoWindow(deal)
    "<img src='#{deal.user.avatar.url}' alt = '' width='130' height='90'>
    <div><b>#{deal.user.name}</b> (#{deal.user.food_type})</div>
    <div> #{deal.user.phone_number} </div>
    </br>

    <div> <i> #{deal.description} </i> </div>
    <div>Start Time: #{deal.start_time} </div>
    <div>End Time: #{deal.end_time}</div>
    <div> <a href=#{deal.user.website}> Website: </div>
    <div hidden> deal_id: #{deal.id}</div>"
  end
end
