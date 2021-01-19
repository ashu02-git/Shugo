class Admins::PostCommentsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_admin!

  def destroy
    comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    comment.destroy
    redirect_to admins_post_path(params[:post_id]), alert: 'コメントを削除しました'
  end
end
