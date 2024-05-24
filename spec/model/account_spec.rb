require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { build(:account) }

  describe 'associations' do
    it { should have_many(:amount_transactions).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:numero_conta) }
    it { should validate_uniqueness_of(:numero_conta).case_insensitive }
    it { should validate_numericality_of(:saldo).is_greater_than_or_equal_to(0) }
  end
end
