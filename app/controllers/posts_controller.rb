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
          File.open(uploaded_file.path) do |f|
            blob = ActiveStorage::Blob.create_and_upload!(
              io: f,
              filename: uploaded_file.original_filename,
              content_type: uploaded_file.content_type
            )
            ImageUploadJob.perform_later('Post', @post.id, blob.id)
          end
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
