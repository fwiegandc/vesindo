require 'test_helper'

class DireccionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup

  	@casa = direcciones(:casa)
  	@dpto_con_torre_2 = direcciones(:departamento_con_torre_2)
  	@dpto_con_torre_1 = direcciones(:departamento_con_torre_1)
  	@casa_en_villa = direcciones(:departamento_con_torre_1)

    @factory = RGeo::Geographic.simple_mercator_factory
    @geolocalizacion = @factory.point(1,2)
    @casa.loc = @geolocalizacion
    @dpto_con_torre_2.loc = @geolocalizacion
    @dpto_con_torre_1.loc = @geolocalizacion
    @casa_en_villa.loc = @geolocalizacion

  end

  test "Direccion válida debiese ser aceptada" do

  	assert @casa.valid?

  end

  test "Direccion invalida no debiese pasar" do

  	@casa.direccion = nil
  	assert_not @casa.valid?

  end

  test "Direccion sin numero no debiese pasar" do

  	@casa.numero = nil
  	assert_not @casa.valid?

  end

  test "direccion sin comuna no debiese pasar" do

    @casa.comuna = nil
    assert_not @casa.valid?

  end

  test "activation_digest debiese ser creado automaticamente" do

    @casa.save
    assert_not @casa.activation_digest.nil?

  end

  test "direccion sin geolocalizacion no debiese entrar a la base de datos" do

    @casa.loc = nil
    assert_not @casa.valid?

  end

  test "no debiese haber dos direcciones iguales, de ningun tipo, en la base de datos" do

    @casa_duplicado = @casa.dup
    @casa.save
    assert_not @casa_duplicado.valid?

  end

  #es el know-how que tengo hasta el momento de las direcciones
  test "Bloque no debiese ser comprobado" do

  	@casa.bloque = nil
  	assert @casa.valid?

  end

  test "Dpto no debiese ser comprobado" do

  	@casa.dpto = nil
  	assert @casa.valid?

  end

  test "Villa no debiese ser comprobado" do

  	@casa.villa = nil
  	assert @casa.valid?

  end



end
