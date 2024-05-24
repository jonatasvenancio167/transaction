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
end
