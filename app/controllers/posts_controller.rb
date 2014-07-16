# encoding: UTF-8
class PostsController < ApplicationController

  def index
    @headers = Post.where(:main => true).order('id DESC').limit(5)
  	@posts = Post.all.order('id DESC').paginate( :page => params[:page] ).limit(8)
    @hots = Post.all.order('view DESC').limit(5)
  end

  def show
  	@post = Post.find(params[:id])
    @post.views+=1
    @post.save
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	if @post.save
  		flash[:success] = "Post creado correctamente"
      redirect_to posts_path
  	else
  		render 'new'
  	end
  end

  def edit
  	@post = Post.find(params[:id])
  	if @post.save
  		flash[:success] = "Post actualizado exitosamente"
  	else
  		render 'edit'
  	end
  end

  def destroy
  	Post.find(params[:id]).destroy
  end

  private

  	def post_params
  		params.require(:post).permit(:title, :author_id, :body)
  	end

end