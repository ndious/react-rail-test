require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    authenticate_all
    @client_one_id = users(:client_one).id
  end

  test "Admin should be able to find all users" do
    get "/users", headers: { Authorization: @token_admin }

    assert_response 200
    assert_equal User.all.count, json_response.count
  end

  test "Admin should be able to find a user" do
    get "/users/#{@client_one_id}", headers: { Authorization: @token_admin }

    assert_response 200
    assert_equal @client_one_id, json_response["user"]["id"]
  end

  test "Admin can create a user" do
    post "/users", params: { email: "test@test.test", password: "password", password_confirmation: "password", role: "admin" }, headers: { Authorization: @token_admin }

    assert_response 201
  end

  test "Admin can delete a user" do
    client = users(:client_two)
    client_email = client.email
    delete "/users/#{client.id}", headers: { Authorization: @token_admin }

    client.reload

    assert_response 200
    assert_equal "deleted", client.password_digest
    assert_not_nil client.deleted_at
    assert_not_equal client_email, client.email
  end

  test "Client should not be able to find a user" do
    get "/users/#{users(:client_two).id}", headers: { Authorization: @token_client }

    assert_response 401
  end

  test "Client should be able to find his own user" do
    authenticate_client
    get "/users/#{@client_one_id}", headers: { Authorization: @token_client }

    assert_response 200
    assert_equal @client_one_id, json_response["user"]["id"]
  end
end
