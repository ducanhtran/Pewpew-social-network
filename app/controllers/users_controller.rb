class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.select_and_order
      .paginate page: params[:page], per_page: Settings.users.per_page
  end

  def show
    @user = User.find_by id: params[:id]
    redirect_to root_path unless @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_profile_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    user = User.find_by id: params[:id]

    if user
      user.destroy
      flash[:success] = t "user.deleted"
    else
      flash[:warning] = t "user.not_found"
    end

    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "login_required"
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless current_user.current_user? @user
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
