class PostsController < ApplicationController

  before_action :logged_in_user, only: [:show, :create, :destroy]
  before_action :correct_user, only: [:create, :destroy]

	def show

		  	@posts = Post.find(params[:id])

	end

	def create

		@post = @current_user.posts.new(post_params)
		if @post.save
			flash[:success] = "Post publicado"
      		redirect_to user_post_path(current_user.id, @post.id)
      	else
      		
      		@posts = MiBarrioPosts(current_user)
      		render 'static_pages/home'
      	end

	end

	private

		def post_params
			params.require(:post).permit(:content)
		end

	    #Confirms the correct user.
	    def correct_user
	      @user = User.find(params[:user_id])
	      redirect_to(root_url) unless current_user?(@user)
	    end

end
