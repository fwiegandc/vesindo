require 'test_helper'

class DireccionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup

  	@casa = direcciones(:casa)
  	@dpto = direcciones(:departamento)
  	@dpto_con_torre_2 = direcciones(:departamento_con_torre_2)
  	@dpto_con_torre_1 = direcciones(:departamento_con_torre_1)
  	@casa_en_villa = direcciones(:departamento_con_torre_1)

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

  test "no debiese haber dos direcciones iguales en la base de datos" do
  end

  #No estoy seguro de este test. Es lo adecuado? Que pasa si queremos 
  test "Direccion debiese tener un hogar" do 
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
