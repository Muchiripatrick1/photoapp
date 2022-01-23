class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end

  def show
    def show
      @favorite = current_user.favorites.find_by(post_id: @post.id)
    end
  end

  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
      if @post.save
        PostMailer.post_mail(@post).deliver
        redirect_to posts_path, notice: "Post Created！"
      else
        render :new
      end
  end
  
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end

  private
  def set_post
  @post = Post.find(params[:id])
  end
  def post_params
  params.require(:post).permit(:content, :image, :user_id)
  end
end