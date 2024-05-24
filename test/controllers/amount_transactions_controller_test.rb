require "test_helper"

class AmountTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @amount_transaction = amount_transactions(:one)
  end

  test "should create amount_transaction" do
    assert_difference("AmountTransaction.count") do
      post amount_transactions_url, params: { numero_conta: @amount_transaction.account.numero_conta, valor: @amount_transaction.valor, forma_pagamento: @amount_transaction.forma_pagamento }, as: :json
    end

    assert_response :created
  end

end
