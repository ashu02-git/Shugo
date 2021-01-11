class Admins::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @new_category = Category.new
  end

  def create
    new_category = Categoriy.new(categoriy_params)
    new_category.save
    redirect_to admins_cateries_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def categories_params
    params.require(:category).permit(:name)
  end
end
