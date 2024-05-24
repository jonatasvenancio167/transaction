class Account < ApplicationRecord
  has_many :amount_transactions, dependent: :destroy

  alias_attribute :numero_conta, :account_number
  alias_attribute :saldo, :balance

  validates :numero_conta, presence: true, uniqueness: true
  validates :saldo, numericality: { greater_than_or_equal_to: 0 }
end
