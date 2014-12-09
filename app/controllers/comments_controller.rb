class CommentsController < ApplicationController
  	before_action :logged_in_user_permitido_en_hogar?
  	before_action :correct_user_for_deleting_comment, only: [:destroy]

  	def create

  		@post = Post.find(params[:post_id])
  		@comment = current_user.comments.build(create_params)
  		if @comment.save
		      flash[:success] = "Comentario ha sido publicado"
		      redirect_to user_post_path(@post.user.id, @post.id)
		else
			flash[:danger] = "Comentario no ha sido publicado. Este intento ha sido reportado"
			redirect_to user_post_path(@post.user.id, @post.id)
		end

  	end

  	def destroy

  		@comment = Comment.find(params[:id])
  		if @comment.destroy
  			flash[:danger] = "Comentario ha sido borrado"
			redirect_to user_post_path(@comment.post.user.id, @comment.post.id)
		end
  	end


  	private
       #Confirms the correct user.
	    def correct_user_for_deleting_comment
	      @comment = Comment.find(params[:id])
	      @user = @comment.user
	      redirect_to(login_url) unless current_user?(@user)
	    end

	    def create_params
	    	params.require(:comment).permit(:content).merge!(:post_id => params[:post_id])
	    end

end
