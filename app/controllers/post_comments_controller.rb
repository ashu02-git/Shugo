class PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    comment.post_id = post.id
    if comment.save
      redirect_to post_path(post.id), notice: 'コメントが投稿されました'
    else
      redirect_to post_path(post.id), alert: 'コメントの投稿に失敗しました'
    end
  end

  def destroy
    comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    # 編集者制限
    if comment.user_id != current_user.id
      redirect_to posts_path, alert: 'アクセスできません'
    else
      comment.destroy
      redirect_to post_path(params[:post_id]), alert: 'コメントを削除しました'
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
