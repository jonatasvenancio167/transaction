class Account < ApplicationRecord
  has_many :amount_transactions, dependent: :destroy

  validates :numero_conta, presence: true, uniqueness: true
  validates :saldo, numericality: { greater_than_or_equal_to: 0 }
end
