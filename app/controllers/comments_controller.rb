class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: 'コメントを追加しました'
    else
      redirect_to @post, alert: 'コメントを入力してください'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image)
  end
end
