class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = sort_posts(Post.all)
  end

  def user_index
    selective_posts = Post.where("user_id = #{params[:id]}")
    @posts = sort_posts(selective_posts)
    render 'index'
  end

  def new
    @post = Post.new
    @post.user_id = current_user.id
  end

  def create
    if user_signed_in?
      @post = Post.create(post_params)
      @post.user_id = current_user.id
      if @post.save
        redirect_to @post
      else
        render 'new'
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
 
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end

  def can_moderate(record)
    current_user != nil && current_user.id == record.user_id
  end
  helper_method :can_moderate

  def sort_posts(posts)
    posts.sort do |a,b|
      comparsion = a.rating <=> b.rating
      if comparsion == 0 
        b.created_at <=> a.created_at
      end
    end
  end
end
