require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe '#validate' do
    it { expect(build(:expense, label: '').valid?).to be_truthy }
    it { expect(build(:expense, cost: nil).valid?).to be_falsey }

    context 'when cost is 0 or positive' do
      it { expect(build(:expense, cost: 0).valid?).to be_truthy }
      it { expect(build(:expense, cost: 1).valid?).to be_truthy }
      it { expect(build(:expense, cost: 2).valid?).to be_truthy }
    end

    context 'when cost is negative' do
      it { expect(build(:expense, cost: -1).valid?).to be_falsey }
      it { expect(build(:expense, cost: -2).valid?).to be_falsey }
    end
  end
end
