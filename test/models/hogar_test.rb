require 'test_helper'

class HogarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup

  	@hogar = hogares(:CEO)
  	@user_admin_hogar = @hogar.user_admin
  	@usuarios_hogar = @hogar.users

  end 

  test "Hogar debe ser poderse grabar bien" do
  	assert @hogar.valid?
  end

  test "Debiese haber un admin por hogar" do

  	@hogar.user_admin = nil
  	assert_not @hogar.valid?

  end

  test "Un usuario no puede ser admin de dos hogares" do

  	@hogar2 = @hogar.dup
  	@hogar.save
  	assert_not @hogar2.valid?
  end


  test "un hogar debiese tener una direccion" do
  end
  
  test "un hogar no puede tener dos direcciones" do
  end

  test "no debiese haber dos hogares con la misma direccion" do
  end

  test "si un hogar es eliminado, todos los integrantes de el deben pasar a no estar validados" do
  end

  test "si un hogar se elimina, la direccion debe ser eliminada" do
  end

  test "si el usuario admin es eliminado, entondes la administracion debe pasar a otro usuario" do
  end
end
