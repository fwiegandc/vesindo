require 'test_helper'

class DireccionesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup

  	@user_sin_hogar = users(:sin_hogar)
  	@user_con_hogar = users(:michael)
  	@direccion_sin_hogar = direcciones(:direccion_sin_hogar)
  	@loc_direccion = loc_geographic_random

  end

  test "debiese estar disponible :new" do

  	log_in_as(@user_sin_hogar)
  	get :new
  	assert :success

  end

  test "usuario que no está logueado debiese ser redireccionado a root" do

  	get :new
  	assert_no_difference 'Direccion.count' do
  		post :create, direccion: { direccion: "bartolome de las casas 1990, Vitacura, Santiago", bloque: "", dpto: "" }
  	end
  	assert_redirected_to login_url

  end

  test "usuario que ya tiene direccion y hogar debiese ser redireccionado a root_url" do

  	log_in_as(@user_con_hogar)
  	get :new
  	assert_redirected_to root_url

  end

  test "direccion válida de casa, nuevo usuario, direccion inexistente, debiese ser insertada, creado el hogar y enviado carta confirmación" do

  	log_in_as(@user_sin_hogar)
  	assert_difference 'Direccion.count',+1 do
  		post :create, direccion: { direccion: "bartolome de las casas 2050, Vitacura, Santiago", bloque: "", dpto: "" }
  	end
  	#Chequeamos que el usuario tenga hogar
  	@user_sin_hogar.reload
  	assert_not @user_sin_hogar.hogar.nil?
  	#Chequeamos que el usuario sea el administrador de ese hogar
  	assert @user_sin_hogar.hogar.user_admin == @user_sin_hogar
  	#Chequeamos que la direccion del hogar no esté validada
  	assert_not @user_sin_hogar.hogar.direccion.activated?
  	#Chequeamos que el usuario no esté permitido en el hogar
  	assert_not @user_sin_hogar.permitido_en_hogar
  	#Chequeamos que se redirige a la pagina de activacion de la direccion
  	assert_redirected_to direccion_activations_edit_path

  end

  test "Si el hogar y la direccion existen, entonces el inscrito debiese ser integrado a el, pero sin ser validado dentro de el, y luego rederigido a root_path" do

  	log_in_as(@user_sin_hogar)
  	#Nos aseguramos que está en la base de datos
  	@hogar = @user_con_hogar.hogar
  	@hogar.save
  	#Mandamos la instruccion
  	assert_no_difference 'Direccion.count' do
  		post :create, direccion: { direccion: "#{@hogar.direccion.direccion} #{@hogar.direccion.numero}, #{@hogar.direccion.comuna.name}, Chile", bloque: @hogar.direccion.bloque , dpto: @hogar.direccion.dpto }
  	end
  	#Verificamos que el usuario ha sido integrado al hogar
  	assert @user_sin_hogar.reload.hogar == @hogar
  	#Verificamos que no esté activo en el hogar
  	assert_not @user_sin_hogar.reload.permitido_en_hogar
  	#Verificamos que fue redirigido a root_path
  	assert_redirected_to root_url

  end

  #test "Inscripcion sin direccion debiese volver a inscribirse, y no debiese ser valida" do
  #	log_in_as(@user_sin_hogar)
  #	debugger
  #	assert_no_difference 'Direccion.count' do
  #		post :create, direccion: { direccion: "1990" , bloque: "", dpto: "" }
  #	end
  #	assert_redirected_to new_direccion_path

  #end

  test "Inscripcion sin numero debiese volver a tener que poner direccion" do
  	log_in_as(@user_sin_hogar)

  	assert_no_difference 'Direccion.count' do
  		post :create, direccion: { direccion: "Bartolome de las casas, Vitacura, Santiago, Chile" , bloque: "", dpto: "" }
  	end

  	assert_template 'direcciones/new'
  end

  test "Direccion que existe en la base de datos, pero que no esta asignada a ningun hogar, nuevo hogar debiese ser creado y el usuario puesto en el" do

  	@direccion_sin_hogar.loc_geographic = @loc_direccion
  	@direccion_sin_hogar.save

	   log_in_as(@user_sin_hogar)

  	assert_no_difference 'Direccion.count' do
  		post :create, direccion: { direccion: "#{@direccion_sin_hogar.direccion} #{@direccion_sin_hogar.numero}, #{@direccion_sin_hogar.comuna.name}, Chile" , bloque: "", dpto: "" }
  	end
  	assert @direccion_sin_hogar.reload.hogar.user_admin == @user_sin_hogar.reload
  	assert @direccion_sin_hogar.reload.hogar == @user_sin_hogar.reload.hogar

  end

end
