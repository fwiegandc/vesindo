require 'test_helper'

class MegustaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup

  	@user = users(:michael)
  	@post = @user.posts.take(1)[0]
  	@megusta = Megusta.new(user: @user, post: @post)

  end

  test "Me gusta valido debiese ser valido y bien grabado" do

  	assert @megusta.valid?
  	assert @megusta.save

  end

  test "Usuario debiese poder poner me gusta en más de un post" do

  		@megusta.save
  	  	@otro_post = posts(:archer_post)
  	  	@otro_me_gusta = Megusta.new(post: @otro_post, user: @user)
  	  	assert @otro_me_gusta.valid?
  	  	assert @otro_me_gusta.save

  end

  test "Me gusta requiere un post" do

  	@megusta.post = nil
  	assert_not @megusta.valid?

  end

  test "Me gusta requiere un usuario" do

  	@megusta.user = nil
  	assert_not @megusta.valid?

  end

  test "Un usuario no puede poner dos veces me gusta a un post" do

  	@megusta_dup = @megusta.dup
  	@megusta.save
  	assert_not @megusta_dup.valid?
  	assert_not @megusta_dup.save

  end


end
