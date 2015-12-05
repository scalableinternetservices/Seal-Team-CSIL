module TimelineHelper
  # def cache_key_for_timeline_deal(deal)
  #   "deal/#{deal.id}/#{deal.updated_at}"
  # end
  
  def get_lat
    if Rails.cache.fetch('lat') == nil
      lat = '34.413347'
    else
      lat = Rails.cache.fetch('lat')
    end
    lat
  end

  def get_lng
    if Rails.cache.fetch('lng') == nil
      lng = '-119.855441'
    else
      lng = Rails.cache.fetch('lng')
    end
    lng
  end
end
