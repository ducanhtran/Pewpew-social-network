class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find_by id: params[:followed_id]
    redirect_to root_path unless user
    current_user.follow user
    redirect_to user
  end

  def destroy
    user = Relationship.find_by(id: params[:id]).followed
    redirect_to root_path unless user
    current_user.unfollow user
    redirect_to user
  end
end
