class SearchesController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]

    if @range == '1'
      @user = User.search(@word)
    else
      @post = Post.search(@word)
    end
  end
end
