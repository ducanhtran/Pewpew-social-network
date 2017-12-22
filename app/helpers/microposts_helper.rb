module MicropostsHelper
  def current_follow id
    current_user.active_relationships.find_by followed_id: id
  end
end
