require 'rails_helper'

RSpec.describe TransactionService, type: :service do
  let(:account) { create(:account, saldo: 1000.0) }

  # Definindo o subject para ser uma instância do serviço com parâmetros fornecidos
  subject { described_class.new(account, amount, transaction_type) }

  describe "#perform_transaction" do
    context "with valid parameters" do
      let(:amount) { 100 }

      context "for debit" do
        let(:transaction_type) { 'D' }

        it "creates a new transaction" do
          expect { subject.perform_transaction }.to change(AmountTransaction, :count).by(1)
        end

        it "updates the account balance correctly" do
          expect { subject.perform_transaction }.to change { account.reload.saldo }.by(-103)
        end

        it "ensures account balance is not negative" do
          subject.perform_transaction
          expect(account.reload.saldo).not_to be_negative
        end
      end

      context "for credit" do
        let(:transaction_type) { 'C' }

        it "creates a new transaction" do
          expect { subject.perform_transaction }.to change(AmountTransaction, :count).by(1)
        end

        it "updates the account balance correctly" do
          expect { subject.perform_transaction }.to change { account.reload.saldo }.by(-105)
        end

        it "ensures account balance is not negative" do
          subject.perform_transaction
          expect(account.reload.saldo).not_to be_negative
        end
      end

      context "for pix" do
        let(:transaction_type) { 'P' }

        it "creates a new transaction" do
          expect { subject.perform_transaction }.to change(AmountTransaction, :count).by(1)
        end

        it "updates the account balance correctly" do
          expect { subject.perform_transaction }.to change { account.reload.saldo }.by(-100)
        end

        it "ensures account balance is not negative" do
          subject.perform_transaction
          expect(account.reload.saldo).not_to be_negative
        end
      end
    end

    context "with insufficient funds" do
      let(:amount) { 2000 }
      let(:transaction_type) { 'D' }

      it "raises an error" do
        expect { subject.perform_transaction }.to raise_error(RuntimeError, 'Fundo insuficiente')
      end
    end

    context "with invalid transaction type" do
      let(:amount) { 100 }
      let(:transaction_type) { 'X' }

      it "raises an error" do
        expect { subject.perform_transaction }.to raise_error(RuntimeError, 'Invalid transaction type')
      end
    end

    context "ensuring no negative balance" do
      let(:amount) { 10 }
      let(:transaction_type) { 'D' }
      
      it "raises an error if transaction would cause negative balance" do
        account.update(saldo: 10) # Setting account balance low to ensure negative balance scenario
        expect { subject.perform_transaction }.to raise_error(RuntimeError, 'Fundo insuficiente')
      end

      it "does not change the account balance if transaction would cause negative balance" do
        account.update(saldo: 10)
        expect { subject.perform_transaction rescue nil }.not_to change { account.reload.saldo }
      end
    end
  end
end
