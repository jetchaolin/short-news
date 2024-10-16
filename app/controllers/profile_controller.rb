class ProfileController < ApplicationController
  before_action :check_username, only: %i[ index ]
  before_action :set_user, only: %i[ manage_user change_user_author ]

  def index
    @user
  end

  def new_user
    @user = current_user
  end

  def manage
    @users = User.all
  end

  def manage_user
    @user
  end

  def edit
    @user
  end

  def update
    if current_user
      @user = current_user
      @user.update(user_params)
      redirect_to root_path
    else
      set_user
      @user.update(user_params)
      redirect_to profile_manage_path
    end
  end

  def change_user_author
    @user.update(author: (@user.author ? false : true))
    redirect_to profile_manage_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :author, :email, :password)
  end

  def check_username
    return if current_admin
    if current_user
      redirect_to profile_new_user_path(current_user.id) if !current_user.username
    else
      redirect_to new_user_registration_path
    end
  end
end
