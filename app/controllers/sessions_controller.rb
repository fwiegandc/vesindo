class SessionsController < ApplicationController
  def new
  end
  def create

  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        remember(user)
        redirect_back_or root_url
      else
        message  = "Esta clave aún no está activa. "
        message += "Porfavor, revisa tu email para verlo."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # Create an error message.
      flash.now[:danger] = 'Email/password invalido' # Not quite right!
      render 'new'
    end

  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
