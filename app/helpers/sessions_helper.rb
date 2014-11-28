module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def tiene_hogar?
    !current_user.hogar.nil?
  end

  def permitido_en_hogar?
    current_user.permitido_en_hogar
  end

  def usuario_con_hogar

    flash[:danger] = "Tu hogar está siendo validado. Hasta que eso ocurra, solo puedes actualizar tu perfíl"
    redirect_to current_user unless tiene_hogar?

  end

  def usuario_sin_hogar

    redirect_to root_path unless current_user.hogar.nil?

  end

  def logged_in_user_permitido_en_hogar?

      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        return redirect_to login_url
      end
      unless tiene_hogar? && permitido_en_hogar?
        store_location
        flash[:danger] = "Please log in."
        redirect_to current_user
      end
  end

  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

    # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

    # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end


end
