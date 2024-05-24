class TransactionService
  DEBIT_FEE = 0.03
  CREDIT_FEE = 0.05

  def initialize(account, amount, transaction_type)
    @account = account
    @amount = amount
    @transaction_type = transaction_type
  end

  def perform_transaction 
    total_amount = calculate_total_amount

    raise 'Fundo insuficiente' if @account.saldo < total_amount

    ActiveRecord::Base.transaction do
      @account.update!(saldo: @account.saldo - total_amount)
      @account.amount_transactions.create!(valor: @amount, forma_pagamento: @transaction_type)
    end

    @account.saldo
  end

  private

  def calculate_total_amount
    case @transaction_type
    when 'D'
      @amount * (1 + DEBIT_FEE)
    when 'C'
      @amount * (1 + CREDIT_FEE)
    when 'P'
      @amount
    else
      raise 'Invalid transaction type'
    end
  end
end