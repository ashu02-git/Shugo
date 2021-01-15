class RelationshipsController < ApplicationController
  bfore_action :set_user

  def create
    following = current_user.follow(@user)
    following.save
    flash[:success] = 'フォローしました'
    redirect_to request.refere
  end

  def destroy
    following = current_user.unfollow(@user)
    following.destroy
    flash[:success] = 'フォローを解除しました'
  end

  private

  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end

end
