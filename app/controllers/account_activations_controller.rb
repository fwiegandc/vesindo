class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      flash[:success] = "Tu cuenta fue activada satisfactoriamente!"
      log_in user
      redirect_to root_url
    else
      flash[:danger] = "Dirección de activacion inválida"
      redirect_to root_url
    end
  end
end
