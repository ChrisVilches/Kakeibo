require 'rails_helper'

RSpec.describe Day, type: :model do
  let(:period) { create :period, date_from: Date.today, date_to: Date.today + 10 }

  describe '#belongs_to_period_range' do
    let(:wrong_day) { build :day, period: period, day_date: Date.today + 100 }
    let(:correct_day) { build :day, period: period, day_date: Date.today + 1 }

    it { expect(wrong_day.valid?).to be_falsey }
    it { expect(correct_day.valid?).to be_truthy }
  end

  describe 'unique validation' do
    before { period.days << build(:day, day_date: period.date_from) }

    it 'prevents days with same day date in period' do
      expect do
        period.days << build(:day, day_date: period.date_from)
      end.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
