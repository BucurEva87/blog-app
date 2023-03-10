class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @author = User.find(params[:user_id])
    @like = @post.likes.new(post: @post, author: @author)
    if @like.save
      redirect_to request.referrer
    else
      render plain: @like.errors.messages
    end
  end

  private

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @like = @post.likes.new(post: @post, author: @author)
  end

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end
end
