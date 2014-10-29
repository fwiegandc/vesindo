class StaticPagesController < ApplicationController
  def home

  	@post = current_user.posts.build if logged_in?
  	@posts = MiBarrioPosts(current_user)

  end
end
