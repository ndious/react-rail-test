ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "minitest/reporters"
require "rails/test_help"

Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def json_response
    JSON.parse(response.body)
  end

  def authenticate_admin
    post "/auth/login", params: { email: users(:admin).email, password: "password" }
    @token_admin = json_response["token"]
  end

  def authenticate_client
    post "/auth/login", params: { email: users(:client_one).email, password: "password" }
    @token_client = json_response["token"]
  end

  def authenticate_all
    authenticate_admin
    authenticate_client
  end
end

