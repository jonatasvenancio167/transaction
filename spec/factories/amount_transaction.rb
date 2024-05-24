FactoryBot.define do
  factory :amount_transaction do
    amount { 100 }
    transaction_type { 'D' }
    account
  end
end
