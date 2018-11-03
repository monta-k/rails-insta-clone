class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
    respond_to do |format|
      format.html { redirect_to new_post_path }
      format.js
    end
  end

  def create
    @post = Post.new(post_params)
    if params[:images]
      if @post.save
        params[:images].each do |img|
          @post.photos.create(image: img)
        end
      else
        redirect_to root_path
        flash[:alert] = "投稿に失敗しました"
      end

      redirect_to root_path
      flash[:notice] = "投稿が保存されました"
    else
      flash.now[:alert] = "投稿する写真を選択してください"
      render 'new'
    end
  end

  private

    def post_params
      params.require(:post).permit(:caption).merge(user_id: current_user.id)
    end

end
