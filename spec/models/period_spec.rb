require 'rails_helper'

RSpec.describe Period, type: :model do
  describe '#dates_in_order' do
    let(:wrong_period) { build :period, date_from: Date.today + 2, date_to: Date.today }

    it { expect(wrong_period.valid?).to be_falsey }
  end

  describe '#dates_are_different' do
    let(:wrong_period) { build :period, date_from: Date.today, date_to: Date.today }

    it { expect(wrong_period.valid?).to be_falsey }
  end

  describe '#amount_days' do
    let(:period) { create :period, date_from: Date.today, date_to: Date.today + 2 }

    it { expect(period.amount_days).to eq 3 }
  end
end
