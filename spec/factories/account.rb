FactoryBot.define do
  factory :account do
    sequence(:numero_conta) { |n| n.to_s.rjust(6, '0') }
    saldo { 200.00 }
  end
end
