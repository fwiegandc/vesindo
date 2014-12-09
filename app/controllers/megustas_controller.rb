class MegustasController < ApplicationController
	#before_ asegurarse que en destroy es el usuairo adecuado
	before_action :logged_in_user_permitido_en_hogar?
	before_action :current_user_can_only_delete_own_megustas, only: [:destroy]

  def create

  	@post = Post.find(post_params)
  	@megusta = Megusta.create(params_megusta_create)
  	if @megusta.save
  		flash[:success] = "El post ha sido marcado como que te gusta"
  		redirect_to root_path
  	else
  		flash[:error] = "El post no ha podido ser marcado como que te gusta"
  		redirect_to user_post_path(@post.user, @post)
  	end
  end

  def destroy

  	@megusta = Megusta.find(params[:id])

  	if @megusta.destroy
  		redirect_to root_path
  	else
  		flash[:error] = "No se ha podido quitar me gusta"
  		redirect_to login_path
  	end

  end


  private
	  def params_megusta_create

	  		params.require(:megusta).permit(:post_id).merge!(user_id: current_user.id)

	  end

	  def post_params
	  	params.require(:megusta).permit(:post_id)[:post_id]
	  end

	  def current_user_can_only_delete_own_megustas
	  	@megusta = Megusta.find(params[:id])
	  	redirect_to login_path unless current_user?(@megusta.user)
	  end
end
