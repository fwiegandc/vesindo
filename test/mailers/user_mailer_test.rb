require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = User.create(name: "Test User", email: "test@example.com",
                       password: "foobar", password_confirmation: "foobar")
    mail = UserMailer.account_activation(user)
    assert_equal "Activación de la cuenta", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["no-reply@vesindo.com"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "password_reset" do
    user = users(:michael)
    user.create_reset_digest
    mail = UserMailer.password_reset(user)
    assert_equal "Recuperación de contraseña", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["no-reply@vesindo.com"], mail.from
    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "nuevo_user_hogar" do
    user = users(:michael)
    nuevo_user = users(:usuario_hogar_michael)
    mail = UserMailer.nuevo_user_hogar(user, nuevo_user)

  end

end
