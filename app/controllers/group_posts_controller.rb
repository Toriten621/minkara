class GroupPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    @post = @group.group_posts.new(post_params.merge(user: current_user))
    if @post.save
      redirect_to group_path(@group), notice: "投稿しました"
    else
      @posts = @group.group_posts.includes(:user).order(created_at: :desc)
      render "groups/show", alert: "投稿に失敗しました"
    end
  end

  def destroy
    @post = @group.group_posts.find(params[:id])
    if @post.user == current_user || @group.owner == current_user
      @post.destroy
      redirect_to group_path(@group), notice: "投稿を削除しました"
    else
      redirect_to group_path(@group), alert: "権限がありません"
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def post_params
    params.require(:group_post).permit(:content)
  end
end
