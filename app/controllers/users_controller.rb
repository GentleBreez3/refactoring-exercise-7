class UsersController < ApplicationController
  before_action :get_user, only: [:show, :follow, :unfollow]
  
  def index
    @users = User.all
  end

  def show
	end

  def follow
    NotificationMailer.followed_email(@user).deliver
    current_user.followees << @user
    redirect_to user_path(@user)
  end
  
  def unfollow
    NotificationMailer.unfollowed_email(@user).deliver
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_to user_path(@user)
  end
  
end
