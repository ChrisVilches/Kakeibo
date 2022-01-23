require 'rails_helper'

RSpec.describe Day, type: :model do
  let(:period) { create :period, date_from: Date.today, date_to: Date.today + 10 }

  describe '#belongs_to_period_range' do
    let(:wrong_day) { build :day, period:, day_date: Date.today + 100 }
    let(:correct_day) { build :day, period:, day_date: Date.today + 1 }

    it { expect(wrong_day).not_to be_valid }
    it { expect(correct_day).to be_valid }
  end

  describe 'unique validation' do
    before { period.days << build(:day, day_date: period.date_from) }

    it 'prevents days with same day date in period' do
      expect do
        period.days << build(:day, day_date: period.date_from)
      end.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe '#memo' do
    it { expect(create(:day, memo: ' aa bb  cc ').memo).to eq 'aa bb cc' }
    it { expect(create(:day, memo: " aa    \n bb  \n cc ").memo).to eq "aa\nbb\ncc" }
    it { expect(create(:day, memo: " aa    \n bb  \n cc ").memo.lines.count).to eq 3 }
    it { expect(create(:day, memo: " aa    \n bb  \n  \n   \n  \n cc ").memo.lines.count).to eq 4 }
    it { expect(create(:day, memo: "hello\nmultiline").memo.lines.count).to eq 2 }
  end

  describe '#expenses' do
    let(:day) { create :day }

    before { 10.times { day.expenses << build(:expense) } }

    context 'when none has been discarded' do
      it { expect(day.expenses.count).to eq 10 }
    end

    context 'when 5 have been discarded' do
      before { 5.times { |i| day.expenses[i].discard! } }

      it { expect(day.expenses.count).to eq 5 }
    end

    context 'when all have been discarded' do
      before { day.expenses.each(&:discard!) }

      it { expect(day.expenses.count).to be_zero }
    end
  end
end
