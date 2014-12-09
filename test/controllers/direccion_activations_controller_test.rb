require 'test_helper'

class DireccionActivationsControllerTest < ActionController::TestCase

	def setup

		@user = users(:michael)
		@user.permitido_en_hogar = false

		@user.hogar.direccion.activated = false
		@user.hogar.direccion.activated_at = nil

		@user.hogar.direccion.loc = loc_geographic_random
		@user.hogar.direccion.create_activation_digest
		@activation_token = @user.hogar.direccion.activation_token

		@user.save
		@user.hogar.save
		@user.hogar.direccion.save

	end

	test "nuevo usuario admin del hogar puede activar su direccion sin problemas" do

		log_in_as(@user)
		get :new
		post :create, direccion_activations: { activation_code: @activation_token }
		@user.reload
		assert @user.hogar.direccion.activated?
		assert @user.permitido_en_hogar?

	end

	test "usuario no logueado no puede activar" do

		post :create, direccion_activations: { activation_code: @activation_token }
		assert_redirected_to login_url
	end

	test "usuario que vuelve activar su hogar debe ser redireccionado a root_url" do

		@user_con_hogar = users(:lana)
		log_in_as(@user_con_hogar)
		get :new
		post :create, direccion_activations: { activation_code: @activation_token }
		assert_redirected_to root_url

	end

	test "usuario que no es admin del hogar no puede activar su direccion" do

		@usuario_hogar_michael = users(:usuario_hogar_michael)
		log_in_as(@usuario_hogar_michael)
		post :create, direccion_activations: { activation_code: @activation_token }
		assert_not @user.hogar.direccion.reload.activated?
		assert_redirected_to login_url

	end

	test "usuario sin hogar debe ser redireccionado a ingresar nueva direccion" do

		@user_sin_hogar = users(:sin_hogar)
		log_in_as(@user_sin_hogar)
		get :new
		assert_redirected_to new_direccion_url

		post :create, direccion_activations: { activation_code: @activation_token }
		assert_redirected_to new_direccion_url

	end

	test "codigo de activacion incorrecto no activa la direccion" do

		log_in_as(@user)
		get :new
		post :create, direccion_activations: { activation_code: 'codigo_incorrecto' }
		@user.reload
		assert_not @user.hogar.direccion.activated?
		assert_not @user.permitido_en_hogar?
		assert_template 'direccion_activations/new'

	end



end
