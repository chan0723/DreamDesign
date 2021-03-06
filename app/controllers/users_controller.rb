class UsersController < ApplicationController
  
  def following
    @title = "Following"
    @user = current_user
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = current_user
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def mylist
    @my_school = current_user.my_schools.build 
    @videos=current_user.videos
    @hot_schools=[]
    current_user.following.each do |user|
      user.my_schools.each do |school|
        @hot_schools.push(school.name) unless @hot_schools.include?(school.name)
      end
    end
  end
  
  def ranking
  end
  
  def list
    @user=User.find(params[:id])
    render 'users/show'
  end
  def create
    @user = User.create( user_params )
  end
  
  private


  def user_params
    params.require(:user).permit(:avatar)
  end
end
