class UsersController < ApplicationController
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
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def hide
    @user.update(is_deleted: true)
    # ログアウトさせる
    reset_session
    flash[:note] = "退会が完了しました。またのご利用をおまちしております"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
