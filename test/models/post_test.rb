require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @post = @user.posts.build(content: "Lorem ipsum")
  end

  test "micropost should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal Post.first, posts(:most_recent)
  end

  test "content should be present " do
    @post.content = " "
    assert_not @post.valid?
  end

end
