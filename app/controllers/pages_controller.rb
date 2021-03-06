class PagesController < ApplicationController
  def index
    if !current_user.present?
      redirect_to "/users/sign_up"
    else
      redirect_to "/create"
    end


  end
  def profile
    @events = Event.all
  end

  def home
    @user_events = current_user.events
  end
  def follower
    @followers = User.find_by_username(params[:username]).followers
  end

  def following
    @following = User.find_by_username(params[:username]).following
  end

  def ranks
    @ranks = User.find_by_username(params[:username]).following.order(hours: :desc)
  end

  def orgnew
  end

  def search
    @users = User.where("username like ? ", "%#{params[:username].chomp.strip}%")
    @cats = Event.where("title like ? ", "%#{params[:username].chomp.strip}%")

    if User.all.count == @users.length
      @users = []
    end

    if Event.all.count == @cats.length
      @cats = []
    end





  end

  def profile
    if (User.find_by_username(params[:id]))
      @username = params[:id]
    else
      redirect_to root_path, :notice=> "User not found"
    end
    # @user_events = UserEvent.where(user_id: params[:id])
    @user_id = User.find_by(username: params[:id]).id
    @user_events = User.find_by(username: params[:id]).events

  end

  def explore
  end
end
