require 'test_helper'

class PostTagsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  	def setup
		@user = users(:michael)
		@tags = Tag.all
	end

	test "debiese haber pestañas de publicacion en los post" do

		log_in_as(@user)
		get root_path
		assert_template 'static_pages/home'
		@tags.each do |tag|

			assert_select "a[href=?]", "#tab_#{tag.slug}", count: 1

		end
	end

	test "solo una pestaña de publicación debe estar activa" do

		log_in_as(@user)
		get root_path
		assert_template 'static_pages/home'
		assert_select "div.post-form li[class=?]", "active", count: 1

	end

	test "cada sección debiese tener un campo hidden con su categoría" do

		log_in_as(@user)
		get root_path
		assert_template 'static_pages/home'
		@tags.each do |tag|

			assert_select "input[value=?]", tag.slug, count: 1

		end

	end
end
