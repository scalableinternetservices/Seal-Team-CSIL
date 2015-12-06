module TimelineHelper
  def cache_key_for_timeline_deal(deal)
    "deal/#{deal.id}/#{deal.updated_at}/#{Deal.count}"
  end

  def get_lat(ip)
    if Rails.cache.fetch('lat' + ip) == nil
      lat = '34.413347'
    else
      lat = Rails.cache.fetch('lat' + ip, expires_in: 12.hours)
    end
    lat
  end

  def get_lng(ip)
    if Rails.cache.fetch('lng' + ip) == nil
      lng = '-119.855441'
    else
      lng = Rails.cache.fetch('lng' + ip, expires_in: 12.hours)
    end
    lng
  end
end
