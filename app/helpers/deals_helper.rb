module DealsHelper
  def cache_key_for_user_deal(deal)
    "deal/#{deal.id}/#{deal.updated_at}/#{Deal.count}"
  end
  
  def cache_key_for_user_deal_table(user, page)
    "timeline_deal_table/#{user.id}/#{page}/#{User.maximum(:updated_at)}/#{Deal.maximum(:updated_at)}/#{Deal.count}"
  end
end
