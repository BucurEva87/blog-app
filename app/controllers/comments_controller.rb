class CommentsController < ApplicationController
  load_and_authorize_resource
  # before_action :authenticate_user!, only: [:create]

  def index
    @post = Post.find(params[:post_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @post.comments }
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    # @comment = Comment.new(comment_params)
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    respond_to do |format|
      puts 'Presenting the format'
      p format

      if @comment.save
        format.html { redirect_to user_post_path(current_user, @post), notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created }
      else
        format.html { render plain: @comment.errors.messages }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to root_path, notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
