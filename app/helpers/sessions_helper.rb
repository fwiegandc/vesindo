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

  def permitido_en_hogar

    unless permitido_en_hogar?
      flash[:danger] = "Debes inscribir tu hogar, o esperar a ser validado en el"
      redirect_to current_user 
    end

  end

  def usuario_es_administrador_del_hogar

    unless current_user.hogar.user_admin == current_user 
      flash[:danger] = "Debes ser el administrador de tu hogar para activar tu dirección"
      redirect_to login_url 
    end
      
  end

  def usuario_no_permitido_en_hogar

    unless !permitido_en_hogar?
      flash[:danger] = "Ya estás permitido en tu hogar, no puedes acceder aquí"
      redirect_to root_url
    end

  end

  def usuario_con_hogar

    unless tiene_hogar?
      flash[:danger] = "Debes inscribir tu hogar antes de ingresar a la red"
      redirect_to new_direccion_path
    end

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
