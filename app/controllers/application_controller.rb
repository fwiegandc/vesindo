class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def MiBarrioPosts(user)
  		@posts = Post.all.paginate(page: params[:page]).per_page(20)
  	end

  	def hogares_disponibles

  		Hogar.all

  	end


end
