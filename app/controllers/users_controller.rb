class UsersController < ApplicationController
  before_action :set_user, except: [:index]

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts.all
  end

  def edit
    # 編集者制限
    if @user.id != current_user.id
      redirect_to user_path(@user.id), alert: 'アクセスできません'
    elsif @user.email == 'guest@guest.com'
      redirect_to user_path(@user.id), alert: 'ゲスト情報は変更できません'
    else
      render :edit
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: '変更が保存されました'
    else
      render :edit
    end
  end

  def hide
    if @user.id != current_user.id
      redirect_to users_path, alert: 'アクセスできません'
    elsif @user.email == 'guest@guest.com'
      redirect_to user_path(@user.id), alert: 'ゲスト情報は変更できません'
    else
      @user.update(is_deleted: true)
      # ログアウトさせる
      reset_session
      flash[:note] = "退会が完了しました。またのご利用をおまちしております"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
