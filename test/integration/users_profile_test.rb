require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
  	log_in_as(@user)
    get user_path(@user)
    assert_match @user.name, response.body
    assert_select 'div.pagination'
    @user.posts.paginate(page: 1).each do |post|
      assert_match post.content, response.body
    end
  end
end
