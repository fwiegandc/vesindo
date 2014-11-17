require 'test_helper'

class ComunaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup

  	@comuna = comunas(:vitacura)

  end

  test "comuna valida debiese insertarse bien" do

  	assert @comuna.valid?

  end

  test "comuna con nombre invalido no debiese ser insertada" do

  	@comuna.name = nil
  	assert_not @comuna.valid?

  end

  test "no debiesen haber dos comunas con el mismo nombre" do

  	@comuna_dup = @comuna.dup
  	@comuna.save
  	assert_not @comuna_dup.valid?

  end

end
