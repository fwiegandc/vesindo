require 'test_helper'

class UsuarioEnHogarActivationsControllerTest < ActionController::TestCase

	def setup

		@user_admin = users(:michael)
		@user_a_validar = users(:usuario_hogar_michael)
		@user_otro_hogar = users(:archer)

	end

	test "usuario es validado en el hogar por el usuario admin" do
		
		log_in_as(@user_admin)
		get :edit, email: @user_a_validar.email
		@user_a_validar.reload
		assert @user_a_validar.permitido_en_hogar?
		assert_redirected_to root_url

	end

	test "usuario que no es del hogar no es validado en el" do

		log_in_as(@user_admin)
		get :edit, email: @user_otro_hogar.email
		@user_otro_hogar.reload
		assert_not @user_a_validar.permitido_en_hogar?
		assert_redirected_to root_url

	end

	test "usuario no se puede validar a si mismo" do

		log_in_as(@user_a_validar)
		get :edit, email: @user_a_validar.email
		@user_a_validar.reload
		assert_not @user_a_validar.permitido_en_hogar?

	end

end
