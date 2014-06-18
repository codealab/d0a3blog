# encoding: UTF-8
class PostsController < ApplicationController

  def index
  	@posts = Post.all.order('id DESC').limit(8).paginate( :page=>params[:page] )
    if params[:author_id]
      @posts = Post.where(:author_id=>params[:author_id]).order('id DESC').limit(8).paginate( :page=>params[:page] )
    end
  end

  def show
  	@post = Post.find(params[:id])
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