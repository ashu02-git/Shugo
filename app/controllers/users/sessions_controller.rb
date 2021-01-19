# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :reject_user, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # ゲストとしてログイン
  def new_guest
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def reject_user
    if @user == User.find_by(email: params[:user][:email].downcase)
      if @user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false)
        redirect_to new_user_session_path, alert: "退会済みです。"
      end
    else
      redirect_to new_user_registration_path, alert: "新規登録をお願いします"
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
