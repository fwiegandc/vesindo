require 'test_helper'

class MegustaPostsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup

  	@user = users(:archer)
  	@post = posts(:mallory_post)

  end

  test "boton me gusta esta disponible, y apretarlo lleva  a pagina de post y suma uno a megustas" do

  	log_in_as(@user)
  	get root_path
  	assert_select "div#post-#{@post.id} input[class=?]", "btn btn-success btn-megusta"
  	assert_difference 'Megusta.count', +1 do

 			post megustas_path, megusta: { post_id: @post.id }

 	end
 	assert_redirected_to root_path


  end

  test "boton no me gusta esta disponible, y apretarlo lleva  a pagina de post y suma uno a megustas" do

  	@megusta = Megusta.create!(user: @user, post: @post)
  	log_in_as(@user)
  	get root_path
 	assert_select "div#post-#{@post.id} input[class=?]", "btn btn-danger btn-nomegusta"
  	assert_difference 'Megusta.count', -1 do

 			delete megusta_path(@megusta)

 	end
 	assert_redirected_to root_path

  end

  test "Las personas a quienes les gusta estan disponibles" do
  end

  test "La misma persona que publico sale como 'A ti' y no como su nombre completo" do
  end

  test "Cuando a solo una persona le gusta el post, sale A X lE gusta esto" do
  end

  test "Cuando a dos personas le gusta, sale 'A X y Y lES gusta esto'" do
  end

  test "Cuando a 3 personas les gusta, sale 'A X, Y y Z lES gusta esto'" do
  end

  test "Cuando a más de 3 personas les gusta un post, y a más de X personas les gusta esto" do
  end


end
