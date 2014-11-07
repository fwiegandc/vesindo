require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:michael)
  	@post = posts(:orange)
  	@comment = @user.comments.build(content: "Lorem", post_id: @post.id)
  end

  test "comentario debiese ser valido" do

  	assert @comment.valid?

  end

  test "comentario debe tener contenido" do

  	@comment.content = ""
  	assert_not @comment.valid?

  end

  test "comentario debe tener usuario" do
  	@comment.user = nil
  	assert_not @comment.valid?
  end

  test "comentario debe pertenecer a un post" do

  	@comment.post = nil
  	assert_not @comment.valid?

  end

  test "orden debe ser de mas antiguo a mas nuevo" do
  	assert_equal Comment.last, comments(:most_recent)
  end

end
