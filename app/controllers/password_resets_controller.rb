class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Fue enviado un email con las instrucciones para resetear tu contraseña"
      redirect_to root_url
    else
      flash.now[:danger] = "El email no fue encontrado en la base de datos"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.password_reset_expired?
      flash[:danger] = "Este link ha expirado. Porfavor, pide uno nuevo."
      redirect_to new_password_reset_path
    elsif @user.update_attributes(user_params)
      if (params[:user][:password].blank? &&
          params[:user][:password_confirmation].blank?)
        flash.now[:danger] = "Clave/Clave de confirmación no puede estar en blanco"
        render 'edit'
      else
        flash[:success] = "La contraseña ha sido reseteada"
        log_in @user
        redirect_to @user
      end
    else
      render 'edit'
    end
  end
  
    private

    def get_user
      @user = User.find_by(email: params[:email])
      unless @user && @user.authenticated?(:reset, params[:id])
        redirect_to root_url
      end
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

end
