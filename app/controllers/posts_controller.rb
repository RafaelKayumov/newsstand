class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def show
  	@post = Post.find(params[:id])
  end

  def index
  	@posts = Post.all.sort do |a,b|
  		comparsion = a.rating <=> b.rating
  		if comparsion == 0 
  			b.created_at <=> a.created_at
  		end
  	end
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.create(post_params)
  	if @post.save
    	redirect_to @post
  	else
    	render 'new'
  	end
  end

  private
  def post_params
  	params.require(:post).permit(:title, :text)
  end
end
