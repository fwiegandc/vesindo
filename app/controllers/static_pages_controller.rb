class StaticPagesController < ApplicationController
  def home

  	@post = current_user.posts.build if logged_in?
  	@posts = MiBarrioPosts(current_user)
  	@tags = Tag.enform

  end
end
