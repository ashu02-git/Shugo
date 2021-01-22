class HomesController < ApplicationController
  def top
    @categories = Category.all
    @all_ranks = Post.order("rate DESC").limit(3)
  end

  def about
  end
end
