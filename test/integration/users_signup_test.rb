require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest


	test "información no valida no debiese pasar" do 

		get new_user_path
		assert_no_difference 'User.count' do 

			post users_path, user:{ name: "", email:"user@invalid", password:"foo", password_confirmation:"bar" }
			
		end

		assert_template 'users/new'
		
	end

	test "Usuario puede loguearse sin problemas" do

		get new_user_path
		assert_difference "User.count" do

			post_via_redirect users_path, user:{ name: "Francisco", email:"user@valid2.com", password:"2081444", password_confirmation:"2081444" }

		end

		assert_template 'users/show'

	end

	test "valid signup information" do
	    get new_user_path
	    name  = "Example User"
	    email = "user@example.com"
	    password = "password"
		    assert_difference 'User.count', 1 do
		      post_via_redirect users_path, user: { name:  name,
		                                            email: email,
		                                            password:              password,
		                                            password_confirmation: password }
		    end
	    assert_template 'users/show'
	    assert is_logged_in?
    end

end
