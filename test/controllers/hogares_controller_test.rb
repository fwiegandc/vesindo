require 'test_helper'

class HogaresControllerTest < ActionController::TestCase

  def setup

    @hogar = hogares(:CEO)
    @user_admin = @hogar.user_admin


  end

  test "should get show" do
    log_in_as(@user_admin)
    get :show, id: @hogar
    assert_response :success
  end

  test "usuario logueado debe poder ver el indice de hogares" do

    log_in_as(@user_admin)
    get :index
    assert_response :success

  end

  test "usuario no logueado no debe poder ver ningun  hogar ni la lista de ellos, y ser redireccionado a root" do
    get :index
    assert_redirected_to login_url

    get :show, id: @hogar
    assert_redirected_to login_url
  end

  test "usuario logueado, con hogar pero no validado en el no puede ver el hogar ni lista de hogares" do
    @user_admin.permitido_en_hogar = false
    @user_admin.save
    log_in_as(@user_admin)
    get :index
    assert_redirected_to @user_admin
    get :show, id: @hogar
    assert_redirected_to @user_admin
  end

  test "usuario debe poder ver solo hogares amigos, del barrio o permitidas" do
  end

end
