class HogaresController < ApplicationController
  before_action :logged_in_user_permitido_en_hogar?

  def index

  	@hogares = hogares_disponibles

  end
  def show

  	@hogar = Hogar.find(params[:id])

  end


end
