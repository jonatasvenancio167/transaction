class AmountTransactionsController < ApplicationController
  before_action :set_account

  def create
    valor = amount_transaction_params[:valor].to_f
    forma_pagamento = amount_transaction_params[:forma_pagamento]

    transaction_service = TransactionService.new(@account, valor, forma_pagamento)

    begin
      update_account = transaction_service.perform_transaction
      render json: update_account, status: :created
    rescue => e
      render json: { error: e.message }, status: :not_found
    end
  end

  private

  def set_account
    @account = Account.find_by(numero_conta: params[:numero_conta])
    render json: { error: 'Account not found' }, status: :not_found unless @account
  end

  def amount_transaction_params
    params.permit(:valor, :forma_pagamento, :numero_conta)
  end
end
