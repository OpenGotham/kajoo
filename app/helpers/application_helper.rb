module ApplicationHelper

  def site_name
    SITE['site_name']
  end
  
  def city_name
    SITE['city_name']
  end
  
  def summary_date(date)
    #March 8, 2011
    date.strftime('%B %d, %Y')
  end 
end
