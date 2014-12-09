require 'test_helper'

class DireccionActivationsActivateTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

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

  test "usuario puede activar su direccion" do

  	log_in_as(@user)
  	#Nos aseguramos de que es redireccionado a activar su direccion
  	get root_path

  	assert_redirected_to new_direccion_activation_url
  	follow_redirect!
  	post direccion_activations_path, direccion_activations: { activation_code: @activation_token }
  	assert_redirected_to root_url
  	#nos aseguramos de que el ususario esté activado
  	follow_redirect!
  	assert_template 'static_pages/home'
  	@user.reload
  	assert @user.permitido_en_hogar?
  	assert @user.hogar.direccion.activated?


  end

  test "mal código de activacion es notificado e impresa la página para volver a insertarlo" do


  	log_in_as(@user)
  	#Nos aseguramos de que es redireccionado a activar su direccion
  	get root_path

  	assert_redirected_to new_direccion_activation_url
  	follow_redirect!
  	post direccion_activations_path, direccion_activations: { activation_code: 'bad_code' }

  	assert_template 'direccion_activations/new'
  	#nos aseguramos de que el ususario esté activado
  	@user.reload
  	assert_not @user.permitido_en_hogar?
  	assert_not @user.hogar.direccion.activated?

  end

end
