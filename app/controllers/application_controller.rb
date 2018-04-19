class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :show_conversations

  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "sessions.login_required"
      redirect_to login_path
    end
  end

  def show_conversations
    session[:conversations] ||= []
    @conversations = Conversation.includes(:recipient, :messages)
      .find session[:conversations]
  end
  
end
