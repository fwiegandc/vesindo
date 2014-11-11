require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup

  	@user = users(:michael)
  	@other_user = users(:archer)
  	@tag = tags(:Seguridad)
  	@post = posts(:orange)

  end

  test "usuarios logueados pueden ver los post" do

  	log_in_as(@user)
  	get :show, user_id: @user, id: @post
  	assert_response :success

  end

  test "usuario puede postear su mensaje" do

    log_in_as(@user)
    assert_difference 'Post.count', +1 do

      post :create, user_id: @user, post: {content: "Usuario puede postear msj", tag: @tag.slug}

    end
  end

  test "solo usuarios logueados pueden postear" do

  	 	assert_no_difference 'Post.count' do

 			post :create, user_id: @user, post: {content: "Solo usuarios logueados pueden postear", tag: @tag.slug}

 		end
 		assert_redirected_to login_url
  end

   test "post sin tag no deberian poder ser posteados correctamente, y ser redireccionado a root_url" do


 		log_in_as(@user)
 		assert_no_difference 'Post.count' do

 			post :create, user_id: @user, post: { content: "Post sin tag", tag: nil }

 		end
 		assert_redirected_to root_url

  end

  test "usuarios no logueados no pueden ver los post" do

  	get :show, user_id: @user, id: @post
  	assert_response :redirect

  end

  test "post de usuario es de el, y no de otro usuario intentando postear por el" do

  		log_in_as(@other_user)
  	 	assert_no_difference 'Post.count' do

 			post :create, user_id: @user, post: {content: "Post pertenece al usuario", tag: @tag.slug}

 		end
 		assert_redirected_to root_path

  end

  test "usuario puede eliminar su mensaje" do
  	log_in_as(@user)
  	@post.save
  	assert_difference 'Post.count', -1 do

 			delete :destroy, user_id: @user, id: @post

 	end
 	assert_redirected_to root_url

  end

  test "solo el usuario debería poder eliminar sus propios mensajes" do

  	log_in_as(@other_user)
  	@post.save
  	assert_no_difference 'Post.count' do

 			delete :destroy, user_id: @user, id: @post

 	end
 	assert_redirected_to root_url
  end

  test "solo usuarios logueados pueden eliminar mensajes" do

  	@post.save
  	assert_no_difference 'Post.count' do

 			delete :destroy, user_id: @user, id: @post

 	end
 	assert_redirected_to login_url

  end

  test "Post con tag invalido no debiese entrar a la base de datos" do

 		log_in_as(@user)
 		assert_no_difference 'Post.count' do

 			post :create, user_id: @user, post: { content: "Post con tag incorrecto", tag: 'tagNoExistente' }

 		end
 		assert_redirected_to root_url

  end

  test "usuario solo puede ver mensajes que le corresponden a uno de sus conjuntos" do
  end

end
