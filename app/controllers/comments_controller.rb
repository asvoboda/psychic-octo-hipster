class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
	
	UserMailer.comment_email(params[:post_id], params[:comment][:commenter]).deliver
	
    redirect_to post_path(@post)
  end
end