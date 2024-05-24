require 'rails_helper'

RSpec.describe AmountTransaction, type: :model do
  subject { build(:amount_transaction) }

  describe 'associations' do
    it { should belong_to(:account) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_presence_of(:transaction_type) }
    it { should validate_inclusion_of(:transaction_type).in_array(%w[D C P]) }
  end
end
