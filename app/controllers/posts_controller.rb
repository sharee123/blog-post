class PostsController < ApplicationController
before_filter :find_post, only: [:show, :edit, :destroy, :update]

	def index
		@posts = Post.all.order("created_at DESC")
	end	

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		if current_user
		@post.user_id = current_user.id
		if @post.save
			redirect_to @post, notice: "Your post is created"
		else
			render 'new'
		end
		end
	end

	def show
	end

	def edit		
	end

	def update
		if @post.update(post_params)
			redirect_to @post, notice: "Your post is updated"
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path, notice: "post destroyed"
	end

	def like
		@post = Post.find(params[:id])
		@tr = @post.liked_by current_user
		redirect_to :back
	end

	def unlike
		@post = Post.find(params[:id])
		@post.unliked_by current_user
		redirect_to :back
	end

	private
	def post_params
		params.require(:post).permit(:title, :content)
	end
	def find_post
		@post = Post.find(params[:id])
	end
	
end
