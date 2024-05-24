require 'rails_helper'

RSpec.describe AmountTransactionsController, type: :controller do
  describe "POST #create" do
    context "with valid parameters" do
      let(:account) { create(:account) }

      it "creates a new transaction" do
        expect {
          post :create, params: { forma_pagamento: 'D', numero_conta: account.numero_conta, valor: 10  }, format: :json
        }.to change(AmountTransaction, :count).by(1)
      end

      it "returns a created response" do
        post :create, params: { forma_pagamento: 'D', numero_conta: account.numero_conta, valor: 10 }, format: :json
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new transaction" do
        expect {
          post :create, params: { forma_pagamento: 'X', numero_conta: nil, valor: nil }, format: :json
        }.to_not change(AmountTransaction, :count)
      end

      it "returns an unprocessable entity response" do
        post :create, params: { forma_pagamento: 'X', numero_conta: nil, valor: nil }, format: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
