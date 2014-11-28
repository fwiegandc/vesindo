require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup

    @user = users(:michael)
    @other_user =  users(:archer)
    @post = posts(:archer_post)
    @comment = comments(:comentario_de_archer_en_tau_manifesto)

  end

  test "deberia redireccionar a log-in page si comenta y no esta logueado" do

   post :create, user_id: @post.user, post_id: @post,  comment: { content: "Lorem ipsum" }
 	 assert_redirected_to login_url

  end

  test "deberia redireccionar a su perfil si comenta, esta loguado, pero no tiene hogar" do

   @user_sin_hogar = users(:sin_hogar)
   log_in_as(@user_sin_hogar)
   post :create, user_id: @post.user, post_id: @post,  comment: { content: "Lorem ipsum" }
   assert_redirected_to login_url

  end

  test "deberia redireccionar a su perfil si comenta, esta loguado, tiene hogar pero no está permitido en el" do
   @user.permitido_en_hogar = false
   @user.save
   log_in_as(@user)
   post :create, user_id: @post.user, post_id: @post,  comment: { content: "Lorem ipsum" }
   assert_redirected_to @user

  end

  test "debería redireccionar a pagina de comentario si se publica bien" do

    log_in_as(@user)
    post :create, user_id: @post.user, post_id: @post,  comment: { content: "Lorem ipsum" }
    assert_redirected_to user_post_url(:user_id => @post.user, :id => @post)

  end

  test "no deberia poder eliminar comentarios de otro usuario y ser redireccionado a login_url" do
    log_in_as(@user)
    delete :destroy, user_id: @post.user, post_id: @post, id: @comment
    assert_redirected_to login_url
  end

  test "deberia poder eliminar sus comentarios y ser redireccionado al post" do
    log_in_as(@other_user)
    delete :destroy, user_id: @post.user, post_id: @post, id: @comment
    assert_redirected_to user_post_url(@comment.post.user.id, @comment.post.id)
  end

end
