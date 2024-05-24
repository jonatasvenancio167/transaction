require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new account" do
        expect {
          post :create, params: { account: { numero_conta: 123456, saldo: 500.0 } }, format: :json
        }.to change(Account, :count).by(1)
      end

      it "returns a created response" do
        post :create, params: { account: { numero_conta: 123456, saldo: 500.0 } }, format: :json
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new account" do
        expect {
          post :create, params: { account: { numero_conta: nil, saldo: nil } }, format: :json
        }.to_not change(Account, :count)
      end

      it "returns an unprocessable entity response" do
        post :create, params: { account: { numero_conta: nil, saldo: nil } }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  describe "GET #show" do
    let(:account) { Account.create(account_number: 123456, balance: 500.0) }

    context "when the account exists" do
      it "returns the account details" do
        get :show, params: { numero_conta: account.account_number }, format: :json
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)["numero_conta"]).to eq(account.numero_conta)
        expect(JSON.parse(response.body)["saldo"]).to eq(account.saldo)
      end
    end

    context "when the account does not exist" do
      it "returns a not found response" do
        get :show, params: { numero_conta: 999 }, format: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
