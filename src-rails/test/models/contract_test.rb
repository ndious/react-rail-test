require "test_helper"

class ContractTest < ActiveSupport::TestCase
  def setup
    @users = [users(:client_one), users(:client_three)]
    @options = [options(:option_one), options(:option_five)]
  end

  test "minimum valid contract" do
    contract = Contract.new start_at: Time.now, users: @users, options: @options

    assert contract.valid?
  end

  test "user cannot subscribe to the same option twice" do
    already_subscribed_options = @users.first.contracts.first.options
    contract = Contract.new start_at: Time.now, users: @users, options: already_subscribed_options

    assert_not contract.valid?
  end

  test "contract cannot created without user" do 
    contract = Contract.new start_at: Time.now, options: @options
    assert_not contract.valid?
  end

  test "contract cannot created without option" do 
    contract = Contract.new start_at: Time.now, users: @users
    assert_not contract.valid?
  end

  test "contract cannot created without start_at" do 
    contract = Contract.new users: @users, options: @options
    assert_not contract.valid?
  end

  test "Contract should automatically update is status on save" do
    contract = Contract.new start_at: Time.now + 1.day, users: @users, options: @options
    contract.save
    assert_equal contract.status, "pending"

    contract.update start_at: Time.now - 2.days
    assert_equal contract.status, "active"

    contract.update end_at: Time.now - 1.day
    assert_equal contract.status, "finished"
  end

  test "Find contracts ended with the status active" do
    contract = contracts(:contract_four)
    contract.update status: :active

    contracts = Contract.not_finished_need_to_be_updated

    assert_equal contracts.count, 1
    assert_equal contracts.first.id, contract.id
  end

end
