class PostsController < ApplicationController
  VOTES = :votes

  before_action :authenticate_user!, except: [:index, :show, :vote]
  before_action :find_user, only: [:user_index]
  before_action :find_post, only: [:show, :vote]
  before_action :find_own_post, only: [:edit, :update, :destroy]

  def show
  end

  def index
    @posts = Post.foremost
  end

  def user_index
    @posts = @user.posts.foremost
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
      redirect_to edit_post_path(@post)
    end
  end

  def vote
    if user_signed_in?
      @post.vote(current_user)
    else
      vote_cookies
    end 
  end

  private
  def vote_cookies
    votes = (cookies[VOTES] || '').split(',')
    existing_vote_id = @post.votes.find_by(id: votes)
    if existing_vote_id
      @post.votes.destroy(existing_vote_id)
      votes.delete(existing_vote_id)
    else
      votes.push(@post.votes.create.id)
    end
    cookies[VOTES] = votes.join(',')
  end
  
  def find_user
    @user = User.find(params[:id])
  end 

  def find_own_post
    @post = current_user.posts.find(params[:id])
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
