class StaticPagesController < ApplicationController
  def home

  	@tags = Tag.enform
  	@post = current_user.posts.build if logged_in?
  	@posts = MiBarrioPosts(current_user)

  end
end
