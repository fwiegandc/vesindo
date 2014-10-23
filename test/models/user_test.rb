require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup

		@user = User.new(name: "Francisco Wiegnad", email:"franciscowiegand@gmail.com", password: "foobar", password_confirmation: "foobar")

	end

	test "usuario debiese estar correcto" do
		assert @user.valid?
	end

	test "nombre debiese tener el usuario" do
		@user.name = ""
		assert_not @user.valid?
	end

	test "email debiese tener el usuario" do
		@user.name = ""
		assert_not @user.valid?
	end

	test "nombre no debiese ser muy largo" do
		@user.name = "a" * 51
		assert_not @user.valid?
	end

	test "email no debiese ser muy largo" do
		@user.email = "a" * 256
		assert_not @user.valid?
	end

	test "email validacion debiese aceptar emails validos" do 

		valid_adresses = %w[user@example.com USER@foo.com A_US-Er@foo.bar.org]
		valid_adresses.each do |address|

			assert @user.valid?, "#{address.inspect} debiese ser valido"

		end

	end

    test "email validacion no debiese aceptar emails no validos" do
    	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    	invalid_addresses.each do |invalid_address|
     	 @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "Email no debiese estar dos veces en la base de datos" do
  	
  		duplicate_user = @user.dup
  		duplicate_user.email = @user.email.upcase
  		@user.save
  		assert_not duplicate_user.valid?

  end

  test "email deberia ser guardada en lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  test "contraseña de usuario debe tener minimo largo" do 

  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  	
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end


end
