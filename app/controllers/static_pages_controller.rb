class StaticPagesController < ApplicationController
  
  before_action :user_logged_in_sin_hogar
  before_action :user_logged_in_con_hogar_es_administrador_no_permitido_en_hogar

  def home

  	@tags = Tag.enform
  	@post = current_user.posts.build if logged_in?
  	@posts = MiBarrioPosts(current_user)

  end

  private

  	def user_logged_in_sin_hogar

		redirect_to new_direccion_path if logged_in? && !tiene_hogar?

  	end

  	def user_logged_in_con_hogar_es_administrador_no_permitido_en_hogar

  		if logged_in? && current_user.hogar.user_admin == current_user && permitido_en_hogar?
  			redirect_to current_user
  		end

  	end
end
