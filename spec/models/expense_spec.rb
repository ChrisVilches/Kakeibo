require 'rails_helper'

RSpec.describe Expense do
  describe '#validate' do
    it { expect(build(:expense, label: '')).to be_valid }
    it { expect(build(:expense, cost: nil)).not_to be_valid }

    context 'when cost is 0 or positive' do
      it { expect(build(:expense, cost: 0)).to be_valid }
      it { expect(build(:expense, cost: 1)).to be_valid }
      it { expect(build(:expense, cost: 2)).to be_valid }
    end

    context 'when cost is negative' do
      it { expect(build(:expense, cost: -1)).not_to be_valid }
      it { expect(build(:expense, cost: -2)).not_to be_valid }
    end
  end

  describe '#label' do
    it { expect(create(:expense, label: ' aa bb  cc ').label).to eq 'aa bb cc' }
    it { expect(build(:expense, label: nil)).to be_valid }
    it { expect { create(:expense, label: nil) }.not_to raise_error }
  end

  describe '#discarded?' do
    it { expect(create(:expense)).not_to be_discarded }
    it { expect(create(:expense, :discarded)).to be_discarded }
  end

  describe '.discarded_before' do
    let(:day) { create(:day) }
    let(:now) { DateTime.new(2021, 5, 10) }

    before do
      10.times { day.expenses << build(:expense) }
      day.expenses << build(:expense, discarded_at: now - 2.minutes)
      day.expenses << build(:expense, discarded_at: now - 5.minutes)
      day.expenses << build(:expense, discarded_at: now - 7.minutes)
      day.save
    end

    it { expect(described_class.discarded_before(now - 0.minutes).count).to eq 3 }
    it { expect(described_class.discarded_before(now - 1.minutes).count).to eq 3 }
    it { expect(described_class.discarded_before(now - 2.minutes).count).to eq 3 }
    it { expect(described_class.discarded_before(now - 3.minutes).count).to eq 2 }
    it { expect(described_class.discarded_before(now - 4.minutes).count).to eq 2 }
    it { expect(described_class.discarded_before(now - 5.minutes).count).to eq 2 }
    it { expect(described_class.discarded_before(now - 6.minutes).count).to eq 1 }
    it { expect(described_class.discarded_before(now - 7.minutes).count).to eq 1 }
    it { expect(described_class.discarded_before(now - 8.minutes).count).to eq 0 }
  end
end
