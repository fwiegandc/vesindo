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
end
