require "test_helper"

class TransactionServiceTest < ActiveSupport::TestCase
  def setup
    @account = accounts(:one)
    @initial_balance = @account.saldo
  end

  test "should perform debit transaction successfully" do
    @service = TransactionService.new(@account, 100, 'D')
    assert_difference('@account.amount_transactions.count', 1) do
      assert_nothing_raised do
        new_balance = @service.perform_transaction
        assert_equal @initial_balance - 103, new_balance
      end
    end
  end

  test "should perform credit transaction successfully" do
    @service = TransactionService.new(@account, 100, 'C')
    assert_difference('@account.amount_transactions.count', 1) do
      assert_nothing_raised do
        new_balance = @service.perform_transaction
        assert_equal @initial_balance - 105, new_balance
      end
    end
  end

  test "should perform payment transaction successfully" do
    @service = TransactionService.new(@account, 100, 'P')
    assert_difference('@account.amount_transactions.count', 1) do
      assert_nothing_raised do
        new_balance = @service.perform_transaction
        assert_equal @initial_balance - 100, new_balance
      end
    end
  end

  test "should raise error for insufficient funds" do
    @service = TransactionService.new(@account, @initial_balance + 1, 'D')
    assert_raises(RuntimeError) do
      @service.perform_transaction
    end
  end
end