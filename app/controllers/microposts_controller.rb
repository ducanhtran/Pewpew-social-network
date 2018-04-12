class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params

    if @micropost.save
      flash[:success] = t "microposts.post_created"
      redirect_to root_url
    else
      @feed = []
      render "static_pages/home"
    end
  end

  def new
    @comment = Comment.new(post_id: params[:micropost_id])
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "microposts.post_deleted"
    else
      flash[:waring] = t "microposts.delete_failed"
    end

    redirect_to request.referrer || root_path
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]

    unless @micropost.present? && current_user.current_user?(@micropost.user)
      redirect_to root_url
    end
  end
end
