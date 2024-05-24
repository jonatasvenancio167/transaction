class AmountTransaction < ApplicationRecord
  belongs_to :account

  alias_attribute :valor, :amount
  alias_attribute :forma_pagamento, :transaction_type
  
  validates :amount, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true, inclusion: { in: %w[D C P] }
end
