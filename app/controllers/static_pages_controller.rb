class StaticPagesController < ApplicationController
  
  before_action :user_logged_in_sin_hogar
  before_action :user_logged_in_con_hogar_es_administrador_no_permitido_en_hogar
  before_action :user_logged_in_con_hogar_no_es_administrador_no_permitido_en_hogar

  def home

  	@tags = Tag.enform
  	@post = current_user.posts.build if logged_in?
  	@posts = MiBarrioPosts(current_user)

  end

  private

  	#Controlamos el comportamiento desde static_pages
  	#Si no tiene direccion ni hogar, rederigimos para que la inserte
  	def user_logged_in_sin_hogar

		  redirect_to new_direccion_path if logged_in? && !tiene_hogar?

  	end

  	#Si tiene hogar y está registrado, pero aún no inserta el permiso para ello
  	def user_logged_in_con_hogar_es_administrador_no_permitido_en_hogar

  		if logged_in? && current_user.hogar.user_admin == current_user && !permitido_en_hogar?
  			redirect_to new_direccion_activation_path
  		end

  	end

  	#Si tiene hogar y está registrado, pero aún no está validado por el dueño del hogar
  	def user_logged_in_con_hogar_no_es_administrador_no_permitido_en_hogar

  		if logged_in? && current_user.hogar.user_admin != current_user && !permitido_en_hogar?
  			flash[:success] = "Un email ha sido enviado al administrador de este hogar para que entres en el. Serás notificado cuando ello ocurra"
  			redirect_to current_user
  		end

  	end

end
