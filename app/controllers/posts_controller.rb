class PostsController < ApplicationController
  before_action :set_post, except: [:new, :create, :index, :hashtag]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.rate ||= 0
    if @post.save
      redirect_to posts_path, notice: '投稿されました'
    else
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
    @categories = Category.all
    @hashtags = Hashtag.all.order("id DESC").limit(20)
    # カテゴリから飛んできた場合
    if params[:category_id].present?
      @posts = Post.where(category_id: params[:category_id])
      @category = Category.find(params[:category_id])
    end
  end

  def show
    @post_comment = PostComment.new
  end

  def edit
    # 編集者制限
    if @post.user_id != current_user.id
      redirect_to posts_path, alert: 'アクセスできません'
    else
      render :edit
    end
  end

  def update
    if params[:post][:rate] == ""
      params[:post][:rate] = "0"
    end
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: '変更が保存されました'
    else
      render :edit
    end
  end

  def destroy
    # 編集者制限
    if @post.user_id != current_user.id
      redirect_to posts_path, alert: 'アクセスできません'
    else
      @post.destroy
      redirect_to posts_path, alert: '投稿を削除しました'
    end
  end

  # ハッシュタグに紐づいたpost一覧
  def hashtag
    @tag = Hashtag.find_by(hash_name: params[:name])
    @posts = @tag.posts
    @categories = Category.all
    @hashtags = Hashtag.all.order("id DESC").limit(20)
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :category_id, :title, :body, :image, :rate)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
