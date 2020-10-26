class RelationshipsController < ApplicationController


  def create
    @user = User.find(params[:relationship][:following_id])
    # binding.pry
    current_user.follow(@user)
    redirect_to users_path
  end

  def destroy
    @user = Relationship.find(params[:id]).following
    current_user.unfollow(@user)
    redirect_to users_path
  end

end
