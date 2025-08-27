class GroupTopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def index
    @topics = @group.group_topics.includes(:user).order(created_at: :desc)
  end

  def show
    @topic = @group.group_topics.find(params[:id])
    @comments = @topic.group_comments.includes(:user).order(created_at: :asc)
    @comment = GroupComment.new
  end

  def new
    @topic = @group.group_topics.new
  end

  def create
    @topic = @group.group_topics.new(topic_params.merge(user: current_user))
    if @topic.save
      redirect_to [@group, @topic], notice: "トピックを作成しました"
    else
      render :new
    end
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end

  def topic_params
    params.require(:group_topic).permit(:title, :content)
  end
end
