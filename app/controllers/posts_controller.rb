class PostsController < ApplicationController
  def index
    @current_user = current_user
    @user = User.includes(posts: { comments: :author }).find(params[:user_id])
  end

  def show
    @current_user = current_user
    @post = Post.find(params['id'])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to user_posts_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
