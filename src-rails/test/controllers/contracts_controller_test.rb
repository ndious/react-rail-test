require "test_helper"

class ContractsControllerTest < ActionDispatch::IntegrationTest

  def setup
    authenticate_all
    @client = users(:client_three)
    @option_one = options(:option_one)
  end

  test "should be possible to create a contract" do
    post "/contracts", 
          params: { start_at: Time.now, clients_id: [@client.id], options_id: [@option_one.id] },
          headers: { Authorization: @token_admin }

    assert_response 201
    assert_not_nil json_response["id"]

    @client.reload
    assert_equal @client.contracts.count, 1
    assert_equal @client.contracts.first.id, json_response["id"]
  end

  test "Admin user should see all contracts" do
    get "/contracts", headers: { Authorization: @token_admin }

    assert_response 200
    assert_equal Contract.all.count, json_response.count
  end

  test "Client user should see only his own contracts" do
    get "/contracts", headers: { Authorization: @token_client }

    assert_response 200
    assert_equal users(:client_one).contracts.count, json_response.count
  end

  test "Client should not see other user's contracts" do
    contract = contracts(:contract_one)
    get "/contracts/#{contract.id}", headers: { Authorization: @token_client }

    assert_response 401
  end

  test "Contract should not be updated by client" do
    contract = users(:client_one).contracts.first
    date_end = 7.days.from_now
    put "/contracts/#{contract.id}", params: { end_at: date_end }, headers: { Authorization: @token_client }

    assert_response 401
  end

  test "Contract should be cancelable by client" do
    contract = users(:client_one).contracts.first
    date_end = Date.current + 7.days
    post "/contracts/#{contract.id}/cancel", params: { end_at: date_end }, headers: { Authorization: @token_client }

    assert_response 204
    contract.reload
    assert_equal contract.end_at, date_end
  end

  test "Contract should be cancelable by admin" do
    contract = users(:client_one).contracts.first
    date_end = Date.current + 9.days
    post "/contracts/#{contract.id}/cancel", params: { end_at: date_end }, headers: { Authorization: @token_admin }

    assert_response 204
    contract.reload
    assert_equal contract.end_at, date_end
  end

  test "Contract should not be cancelable if it is already finished" do
    contract = users(:client_one).contracts.first
    contract.end_at = Date.current - 1.day
    contract.save
    date_end = Date.current + 7.days
    post "/contracts/#{contract.id}/cancel", params: { end_at: date_end }, headers: { Authorization: @token_client }

    assert_response 422
  end

  test "Contract should not be cancelable if the end_at is in the past" do 
    contract = users(:client_one).contracts.first
    date_end = Date.current - 1.day
    post "/contracts/#{contract.id}/cancel", params: { end_at: date_end }, headers: { Authorization: @token_client }

    assert_response 422
  end
end

