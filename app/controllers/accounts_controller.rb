class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :update, :destroy]

  # POST /accounts
  def create
    @account = Account.new(account_params)

    if @account.save
      render json: { numero_conta: @account.numero_conta, saldo: @account.saldo }, status: :created
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  def show
    if @account
      render json: { numero_conta: @account.numero_conta, saldo: @account.saldo }, status: 200
    else
      render json: { error: 'Account not found' }, status: :not_found
    end
  end

  private

  def set_account
    @account = Account.find_by(account_number: params[:numero_conta])
  end

  def account_params
    params.require(:account).permit(:numero_conta, :saldo)
  end
end
