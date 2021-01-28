class HomesController < ApplicationController
  def top
    @categories = Category.all
    @hashtags = Hashtag.all.order("id DESC").limit(20)
    @all_ranks = Post.order("rate DESC").limit(3)
  end

  def about
  end

  def form
  end
end
