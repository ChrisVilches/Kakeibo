require 'rails_helper'

RSpec.describe Day, type: :model do
  let(:period) { create :period, date_from: Date.today, date_to: Date.today + 2 }

  describe '#belongs_to_period_range' do
    let(:wrong_day) { build :day, period: period, day_date: Date.today + 100 }
    let(:correct_day) { build :day, period: period, day_date: Date.today + 1 }

    it { expect(wrong_day.valid?).to be_falsey }
    it { expect(correct_day.valid?).to be_truthy }
  end
end
