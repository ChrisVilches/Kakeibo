require 'rails_helper'

RSpec.describe Period, type: :model do
  pending 'the days method in a Period instance should fetch only the days contained in the range (so that the range can be updated without affecting this)'

  describe '#dates_in_order' do
    let(:wrong_period) { build :period, date_from: Date.today + 20, date_to: Date.today }

    it { expect(wrong_period.valid?).to be_falsey }
  end

  describe '#dates_are_different' do
    let(:wrong_period) { build :period, date_from: Date.today, date_to: Date.today }

    it { expect(wrong_period.valid?).to be_falsey }
  end

  describe '#amount_days' do
    let(:period) { create :period, date_from: Date.today, date_to: Date.today + 20 }

    it { expect(period.amount_days).to eq 21 }
  end

  describe '#period_length_correct' do
    context 'when period is OK' do
      let(:period) { build :period, date_from: Date.today - 15, date_to: Date.today + 15 }

      it { expect(period.valid?).to be true }
    end

    context 'when period is too long' do
      let(:period) { build :period, date_from: Date.today - 1000, date_to: Date.today + 1000 }
      let(:error_messages) { period.errors.full_messages }

      before { period.validate }

      it { expect(period.valid?).to be false }
      it { expect(error_messages.count).to eq 1 }
      it { expect(error_messages.first).to eq 'period length cannot be longer than 100 days' }
    end

    context 'when period is too short' do
      let(:period) { build :period, date_from: Date.today - 1, date_to: Date.today + 2 }
      let(:error_messages) { period.errors.full_messages }

      before { period.validate }

      it { expect(period.valid?).to be false }
      it { expect(error_messages.count).to eq 1 }
      it { expect(error_messages.first).to eq 'period length cannot be shorter than 7 days' }
    end
  end
end
