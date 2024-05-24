require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    ActiveRecord::Base.connection.begin_transaction
    @account_attributes = { numero_conta: generate_unique_account_number, saldo: 200.00 }
    @existing_account = accounts(:one)
  end

  teardown do
    ActiveRecord::Base.connection.rollback_transaction
  end

  test "should create account" do
    assert_difference("Account.count", 1) do
      post accounts_url, params: { account: @account_attributes }, as: :json
    end

    assert_response :created
  end

  test "should not create account with duplicate account number" do
    duplicate_account_attributes = { numero_conta: @existing_account.numero_conta, saldo: 300.00 }
    assert_no_difference("Account.count") do
      post accounts_url, params: { account: duplicate_account_attributes }, as: :json
    end

    assert_response :unprocessable_entity
  end
  
  private

  def generate_unique_account_number
    loop do
      number = rand(1000..9999)
      return number unless Account.exists?(numero_conta: number)
    end
  end
end
