ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  #
  # kill verbsity
  #
  verbosity = $-v
  $-v = nil

  # Add more helper methods to be used by all tests here...
    def is_logged_in?
    !session[:user_id].nil?
  end

    # Logs in a test user.
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, session: { email:       user.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
      session[:user_id] = user.id
    end
  end

  def MiBarrioPosts(user)
    @posts = Post.all.paginate(page: 1).per_page(20)
  end

    private

    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end

    def loc_geographic_random
      @factory = RGeo::Geographic.simple_mercator_factory
      @factory.point(rand(0..30), rand(0..30))
    end

end
