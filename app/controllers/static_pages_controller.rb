class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed = current_user.microposts.order(id: :desc)
        .paginate page: params[:page], per_page: Settings.home.index.feed_per_page
    end
  end

  def help
  end
end
