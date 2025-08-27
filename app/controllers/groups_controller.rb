class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner, only: [:edit, :update, :destroy]

  def group_params
    params.require(:group).permit(:name, :description, user_ids: [])
  end

  def ensure_owner
    redirect_to groups_path, alert: "権限がありません" unless @group.owner == current_user
  end

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
    @users = User.all
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    if @group.save
      GroupUser.find_or_create_by(group: @group, user: current_user)
      redirect_to @group, notice: "グループを作成しました"
    else
      @users = User.all
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: "グループを更新しました"
    else
      render :edit
    end
  end
  def destroy
    @group.destroy
    redirect_to groups_path, notice: "グループを削除しました"
  end
  def join
    group = Group.find(params[:id])
    unless group.users.include?(current_user)
      group.users << current_user
    end
    redirect_to group_path(group), notice: "グループに参加しました"
  end

  def leave
    group = Group.find(params[:id])
    if group.users.include?(current_user)
      group.users.delete(current_user)
    end
    redirect_to groups_path, notice: "グループを脱退しました"
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, user_ids: [])
  end
end
