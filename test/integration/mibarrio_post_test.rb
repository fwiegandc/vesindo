require 'test_helper'

class MibarrioPostTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup

  	@user = users(:michael)

  end

 	test "Post valido debiese ser posteado y luego redireccionado a la página del post" do

 		log_in_as(@user)
 		get root_path
 		assert_difference 'Post.count', +1 do

 			post user_posts_path(@user.id), post: {content: "holaa"}

 		end
 		follow_redirect!
 		assert_template 'posts/show'
 		assert_not flash.empty?

	end

	test "Post no debiese ser valido y ser redireccionado a la página del barrio" do

		log_in_as(@user)
		get root_path
 		assert_no_difference 'Post.count' do

 			post user_posts_path(@user.id), post: {content: ""}

 		end
 		assert_template root_path

	end

	test "Usuario debiese ver los post y el paginamiento en la página principal" do
		log_in_as(@user)
		get root_path
		assert_select 'div.pagination'
    	MiBarrioPosts(@user).each do |post|
      		assert_match post.content, response.body
    	end
	end

end
