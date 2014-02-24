module ApplicationHelper
  
  activities = PublicActivity::Activity.order("created_at desc")

end
