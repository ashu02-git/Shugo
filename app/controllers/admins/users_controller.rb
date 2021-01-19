class Admins::UsersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :set_user, except: [:index]

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admins_user_path(@user.id), notice: '変更が保存されました'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_deleted)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
