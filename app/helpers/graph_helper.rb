module GraphHelper

  def createInfoWindow(deal)
    "<img src='#{deal.user.avatar.url}' alt = '' width='130' height='90'>
    <div><b>#{deal.user.name}</b> (#{deal.user.food_type})</div>
    <div> #{deal.user.phone_number} </div>
    </br>
    <i> #{deal.description} </i>
    #{deal.start_time}
    #{deal.end_time}
    <div> <a href=#{deal.user.website}> Website</div>"
  end
end
