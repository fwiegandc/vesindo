require 'test_helper'

class MegustasControllerTest < ActionController::TestCase

	def setup
		@user = users(:michael)
		@other_user = users(:archer)
		@post = @user.posts[0]

	end

  test "debiese poder poner me gusta" do
  	log_in_as(@user)
  	post :create, megusta: { post_id: @post }
  	assert_redirected_to root_url
  end

  test "debiese poder poner no me gusta" do

  	log_in_as(@user)
  	#guardamos el post en la base de datos
  	@megusta = Megusta.create!(post: @post, user: @user)

  	#y ahora lo borramos de la base de datos
  	assert_difference 'Megusta.count', -1 do

  		delete :destroy, id: @megusta

  	end
  	assert_redirected_to root_url

  end

  test "usuario no logueado no debiese poder poner me gusta" do

  	post :create, megusta: { post_id: @post }
  	assert_redirected_to login_url

  end

  test "usuario loguado pero sin hogar no puede poner me gusta" do
    @user.permitido_en_hogar = false
    @user.save
    log_in_as(@user)
    assert_no_difference "Megusta.count" do
      post :create, megusta: { post_id: @post }
    end
    assert_redirected_to @user
  end

  test "solo el usuario puede destruir sus me gusta" do

  	log_in_as(@other_user)
  	@megusta_user = megustas(:one)
  	assert_no_difference 'Megusta.count' do

  		delete :destroy, id: @megusta_user

  	end
  	assert_redirected_to login_url

  end

  test "usuario solo debería poder poner me gusta a posts disponibles para el" do
  end

  test "cuando se apreta me gusta, debe volver a la página y la posición en donde lo puso" do
  end

end
