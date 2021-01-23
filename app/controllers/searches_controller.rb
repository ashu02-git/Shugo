class SearchesController < ApplicationController
  skip_before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    @categories = Category.all
    @hashtags = Hashtag.all.order("id DESC").limit(20)

    if @range == '1'
      @user = User.search(@word)
    else
      @posts = Post.search(@word)
    end
  end
end
