FactoryBot.define do
  factory :account do
    sequence(:account_number) { |n| n.to_s.rjust(6, '0') }
    balance { 200.00 }
  end
end
