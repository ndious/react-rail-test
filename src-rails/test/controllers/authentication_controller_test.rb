require "test_helper"

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "should be possible to a client to connect" do
    post "/auth/login", params: { email: users(:client_one).email, password: "password" }

    assert_response 200
    assert_not_nil json_response["token"]
  end   

  test "should be possible to an admin to connect" do
    post "/auth/login", params: { email: users(:admin).email, password: "password" }

    assert_response 200
    assert_not_nil json_response["token"]
  end

  test "should not be possible to connect with wrong credentials" do
    post "/auth/login", params: { email: users(:client_one).email, password: "wrong_password" }

    assert_response 401
  end
end
