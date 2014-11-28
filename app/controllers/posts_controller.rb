class PostsController < ApplicationController

  before_action :logged_in_user_permitido_en_hogar?, only: [:show, :create, :destroy]
  before_action :correct_user, only: [:create, :destroy]
  before_action :has_tag, only: [:create]

	def show

		  	@posts = Post.find(params[:id])
		  	#@tags = Tag.enform

	end

	def create


		@post = @current_user.posts.new(post_params)
		if @post.save
			flash[:success] = "Post publicado"
      		redirect_to user_post_path(current_user.id, @post.id)
      	else

      		@posts = MiBarrioPosts(current_user)
      		@tags  = Tag.enform
      		render 'static_pages/home'
      	end

	end

	def destroy

		@post = current_user.posts.find(params[:id])
		if @post.destroy
			flash[:success] = "Post eliminado"
			redirect_to root_url
		else
			flash[:success] = "Post no pudo ser eliminado. Ingrese como el usuario correspondiente"
			redirect_to login_url
		end

	end


	private

		def post_params
			@tag = Tag.where(slug: params.require(:post).permit(:tag)[:tag])
			params.require(:post).permit(:content).merge!(tag: @tag[0])
		end

		def has_tag

			@tag = Tag.where(slug: params.require(:post).permit(:tag)[:tag])
			redirect_to root_url if @tag.empty?
			
		end

	    #Confirms the correct user.
	    def correct_user
	      @user = User.find(params[:user_id])
	      redirect_to(root_url) unless current_user?(@user)
	    end

end
