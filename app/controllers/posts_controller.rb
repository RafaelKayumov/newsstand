class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :vote_up]
  before_action :find_user, only: [:user_index]
  before_action :find_post, only: [:show, :edit, :update, :destroy, :vote_up]

  def show
  end

  def index
    @posts = Post.popular_and_newest
  end

  def user_index
    @posts = @user.posts.popular_and_newest
    render 'index'
  end

  def new
    @post = Post.new
  end

  def create
    if current_user.posts.create(post_params)
      redirect_to posts_path, notice: 'Post was created'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path
    else 
      redirect_to 'edit'
    end
  end

  def vote_up
    @post.vote_up(current_user, request.remote_ip)
  end

  private
  def find_user
    @user = User.find(params[:id])
  end 

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
