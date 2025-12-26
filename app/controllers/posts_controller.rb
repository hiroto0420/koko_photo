class PostsController < ApplicationController
  def index
    @posts = Post.with_attached_images
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      if post_params[:images].present?
        post_params[:images].reject(&:blank?).each do |uploaded_file|
          blob = @post.images.attach(uploaded_file).last.blob
          ImageUploadJob.perform_later('Post', @post.id, blob.id)
        end
      end
      redirect_to posts_path, notice: "投稿しました"
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
