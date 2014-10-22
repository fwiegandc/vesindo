require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
	end

	test "Usuario no pudiese porder editar con estos datos de registro" do

		log_in_as(@user)
		get edit_user_path(@user)
		patch user_path(@user), user: {name: '', email: 'invalid@email', password:'foo', password_confirmation:'bar'}
		assert_template 'users/edit'
		
	end

	test 'usuario debiese poder editar sin problemas su perfil' do

		log_in_as(@user)
		get edit_user_path(@user)
		patch user_path(@user), user: {name: 'Foo bar', email: 'foo@bar.com', password:'', password_confirmation:''}
		assert_not flash.empty?
    	assert_redirected_to @user
    	@user.reload
    	assert_equal @user.name, 'Foo bar'
    	assert_equal @user.email, 'foo@bar.com'

	end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "foobar",
                                    password_confirmation: "foobar" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name,  name
    assert_equal @user.email, email
  end

end
