require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:archer)
    # This code is not idiomatically correct.
    @post = posts(:orange)

  end

  test "micropost should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user = nil
    assert_not @post.valid?
  end

  test "post tag should be present" do
    @post.tag = nil
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal Post.first, posts(:most_recent)
  end

  test "content should be present " do
    @post.content = " "
    assert_not @post.valid?
  end

  test "comentarios deben ser borrados si el post se elimina" do 

    @post.save
    @user2 = User.create!(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    @post2 = @user2.posts.create!(content: "Lorem", tag: @post.tag)
    @user2.comments.create!(content: "Lorem", post: @post2)

    assert_difference 'Comment.count', -1 do
      @post2.destroy
    end

  end

  test "cuando se borra un post, se borran los me gusta asociados a el" do

    @post2 = posts(:mallory_post)
    @megusta2 = Megusta.create!(user: @post.user, post: @post2)
    assert_difference 'Megusta.count', -1 do
      @post2.destroy
    end

  end

end
