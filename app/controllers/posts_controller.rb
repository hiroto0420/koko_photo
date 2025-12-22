class PostsController < ApplicationController
  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "投稿しました"
    else
      render :new, status: unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
