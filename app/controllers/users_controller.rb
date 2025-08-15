class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]

  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'ユーザー情報を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_user_registration_path, notice: '退会しました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to root_path, alert: '権限がありません。' unless @user == current_user
    redirect_to user_path(current_user), alert: "他のユーザーの情報は編集できません。" unless @user == current_user
  end
end
