# encoding: UTF-8
class PostsController < ApplicationController

  def index
    @headers = Post.where(:main => true).order('id DESC').limit(5)
    if params[:user_id]
      query = User.find(params[:user_id]).posts
    elsif params[:tag_id]
      query = Tag.find_by_name(params[:tag_id]).posts
    else 
      query = Post.all
    end
    @posts = query.order('id DESC').page(params[:page])
    @hots = Post.all.order('view DESC').limit(5)
  end

  def show
  	@post = Post.find(params[:id])
    @prev_post = Post.all.order('id DESC').where("id < #{@post.id}").limit(1).first || Post.last
    @next_post = Post.all.order('id ASC').where("id > #{@post.id}").limit(1).first || Post.first
    @post.save
  end

  def new
  	@post = Post.new({
      user_id: current_user.id,
      title: "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
      credits: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Saepe consequatur ipsum sunt soluta quidem deleniti delectus nostrum quas, dolore eos fugit consequuntur ipsa ad ex voluptatum! Voluptates ipsam, architecto nemo.",
      text: "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p><p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident.</p>"
      })
    if @post.save
      redirect_to edit_post_path(@post)
    else
      flash[:warning] = "Ocurrió un error al crear el post"
    end
  end

  def tag
    @post = Post.find(params[:post_id])
    @tag = Tag.find(params[:tag_id])

    if @post.tags.include?(@tag)
      @posttag=PostTag.find_by_post_id_and_tag_id( @post.id, @tag.id ).destroy
    else
      @posttag=PostTag.create( post_id: @post.id, tag_id: @tag.id )
    end
  end

  def edit
  	@post = Post.find(params[:id])
    @resource = @post.resources.build
  end

  def update
    @post = Post.find(params[:id])
    #@post.update_attributes(post_params)
    respond_to do |format|
      if @post.update_attributes(post_params)
        format.js
      end
    end
  end

  def destroy
  	Post.find(params[:id]).destroy
  end

  private

  	def post_params
  		params.require(:post).permit(:title, :cover, :text, :main, :post_type_id, :user_id, :credits, :attr_modified)
  	end

end