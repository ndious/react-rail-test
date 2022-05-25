require "test_helper"

class OptionsControllerTest < ActionDispatch::IntegrationTest
  
  test "Admin should be able list all options available" do
    authenticate_admin
    get "/options", headers: { Authorization: @token_admin }

    assert_response 200
    assert_equal Option.all.count, json_response.count
  end

  test "Admin should be able to see a option" do
    authenticate_admin
    option = options(:option_one)
    get "/options/#{option.id}", headers: { Authorization: @token_admin }

    assert_response 200
    assert_equal option.id, json_response["id"]
  end
end
