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
  end
  def ranking
  end

end
