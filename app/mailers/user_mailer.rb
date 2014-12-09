class UserMailer < ActionMailer::Base
  default from: "no-reply@vesindo.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activación de la cuenta"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Recuperación de contraseña"
  end

  def nuevo_user_hogar(user_admin, user_nuevo)

    @user = user_admin
    @nuevo_user = user_nuevo
    mail to: @user.email, subject: "#{@nuevo_user.name} quiere ingresar a tu hogar"

  end

end
