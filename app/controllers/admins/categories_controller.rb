class Admins::CategoriesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :set_category, except: [:index, :create]

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to admins_categories_path
  end

  def edit
  end

  def update
    @category.update(category_params)
    redirect_to admins_categories_path
  end

  def destroy
    @category.destroy
    redirect_to admins_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
