class Admins::PostsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :set_post, except: [:index]

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  def update
    if params[:post][:rate] == ""
      params[:post][:rate] = "0"
    end
    if @post.update(post_params)
      redirect_to admins_post_path(@post.id), notice: '変更が保存されました'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to admins_posts_path, alert: '投稿を削除しました'
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :category_id, :title, :body, :image, :rate)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
