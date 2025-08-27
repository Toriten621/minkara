class GroupCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic

  def create
    @comment = @topic.group_comments.new(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to [@topic.group, @topic], notice: "コメントを投稿しました"
    else
      @comments = @topic.group_comments.includes(:user).order(created_at: :asc)
      render "group_topics/show"
    end
  end

  private
  def set_topic
    @topic = GroupTopic.find(params[:group_topic_id])
  end

  def comment_params
    params.require(:group_comment).permit(:content)
  end
end
