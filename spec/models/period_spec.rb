require 'rails_helper'

RSpec.describe Period do
  describe '#daily_expenses' do
    it { expect(build(:period, daily_expenses: nil)).not_to be_valid }
    it { expect(build(:period, daily_expenses: -1)).not_to be_valid }
    it { expect(build(:period, daily_expenses: 0)).to be_valid }
    it { expect(build(:period, daily_expenses: 1)).to be_valid }
  end

  describe '#salary' do
    it { expect(build(:period, salary: nil)).not_to be_valid }
    it { expect(build(:period, salary: -1)).not_to be_valid }
    it { expect(build(:period, salary: 0)).to be_valid }
    it { expect(build(:period, salary: 1)).to be_valid }
  end

  describe '#total_fixed_expenses' do
    it { expect(build(:period, total_fixed_expenses: nil)).not_to be_valid }
    it { expect(build(:period, total_fixed_expenses: -1)).not_to be_valid }
    it { expect(build(:period, total_fixed_expenses: 0)).to be_valid }
    it { expect(build(:period, total_fixed_expenses: 1)).to be_valid }
  end

  describe '#dates_in_order' do
    let(:wrong_period) { build(:period, date_from: Date.today + 20, date_to: Date.today) }

    it { expect(wrong_period).not_to be_valid }
  end

  describe '#dates_are_different' do
    let(:wrong_period) { build(:period, date_from: Date.today, date_to: Date.today) }

    it { expect(wrong_period).not_to be_valid }
  end

  describe '#amount_days' do
    let(:period) { create(:period, date_from: Date.today, date_to: Date.today + 20) }

    it { expect(period.amount_days).to eq 21 }
  end

  describe '#period_length_correct' do
    context 'when period is OK' do
      let(:period) { build(:period, date_from: Date.today - 15, date_to: Date.today + 15) }

      it { expect(period.valid?).to be true }
    end

    context 'when period is too long' do
      let(:period) { build(:period, date_from: Date.today - 1000, date_to: Date.today + 1000) }
      let(:error_messages) { period.errors.full_messages }

      before { period.validate }

      it { expect(period.valid?).to be false }
      it { expect(error_messages.count).to eq 1 }
      it { expect(error_messages.first).to eq 'period length cannot be longer than 100 days' }
    end

    context 'when period is too short' do
      let(:period) { build(:period, date_from: Date.today - 1, date_to: Date.today + 2) }
      let(:error_messages) { period.errors.full_messages }

      before { period.validate }

      it { expect(period.valid?).to be false }
      it { expect(error_messages.count).to eq 1 }
      it { expect(error_messages.first).to eq 'period length cannot be shorter than 7 days' }
    end
  end

  describe '#days' do
    subject { period.days.count }

    let(:period) { build(:period, date_from: Date.today, date_to: Date.today + 15) }

    before do
      period.days << build(:day, day_date: Date.today + 2)
      period.days << build(:day, day_date: Date.today + 7)
      period.days << build(:day, day_date: Date.today + 10)
      period.save!
    end

    context 'when days are not added in order' do
      before do
        period.days << build(:day, day_date: Date.today + 5)
        period.reload
      end

      it { is_expected.to eq 4 }
      it { expect(period.days[0].day_date).to eq Date.today + 2 }
      it { expect(period.days[1].day_date).to eq Date.today + 5 }
      it { expect(period.days[2].day_date).to eq Date.today + 7 }
      it { expect(period.days[3].day_date).to eq Date.today + 10 }
    end

    context 'when period has not been edited' do
      it { is_expected.to eq 3 }
    end

    context 'when period has been edited but contains all days added' do
      before { period.update date_from: Date.today - 10, date_to: Date.today + 20 }

      it { is_expected.to eq 3 }
    end

    context 'with date_from increased' do
      context 'when date_from is equal to the first day added' do
        before { period.update date_from: Date.today + 2 }

        it { is_expected.to eq 3 }
      end

      context 'when date_from > first day added' do
        before { period.update date_from: Date.today + 3 }

        it { is_expected.to eq 2 }
      end
    end

    context 'with date_to reduced' do
      context 'when date_to is equal to the last day added' do
        before { period.update date_to: Date.today + 10 }

        it { is_expected.to eq 3 }
      end

      context 'when date_to < last day added' do
        before { period.update date_to: Date.today + 9 }

        it { is_expected.to eq 2 }
      end
    end
  end

  describe '#name' do
    it { expect(create(:period, name: ' aa   bb ').name).to eq 'aa bb' }
  end

  describe '#full_days' do
    let(:period) { create(:period, date_from: Date.today, date_to: Date.today + 7) }

    shared_examples 'full days list has correct length and is sorted' do
      it { expect(period.full_days.count).to eq 8 }

      it 'sorts days correctly' do
        day_dates = period.full_days.collect(&:day_date)
        expect(day_dates).to eq day_dates.sort
      end
    end

    context 'when period has no days added' do
      it { expect(period.days.count).to eq 0 }

      it_behaves_like 'full days list has correct length and is sorted'
    end

    context 'when period has one day added' do
      before { period.days << build(:day, day_date: Date.today + 5) }

      it { expect(period.days.count).to eq 1 }
      it { expect(period.full_days.collect(&:id)).to eq [nil, nil, nil, nil, nil, 1, nil, nil] }

      it_behaves_like 'full days list has correct length and is sorted'
    end

    context 'when period has three days added' do
      before do
        period.days << build(:day, day_date: Date.today + 5)
        period.days << build(:day, day_date: Date.today)
        period.days << build(:day, day_date: Date.today + 7)
      end

      it { expect(period.days.count).to eq 3 }
      it { expect(period.full_days.collect(&:id)).to eq [2, nil, nil, nil, nil, 1, nil, 3] }

      it_behaves_like 'full days list has correct length and is sorted'
    end

    context 'when period has two days added at the start and end (edge cases)' do
      before do
        period.days << build(:day, day_date: Date.today + 7)
        period.days << build(:day, day_date: Date.today)
      end

      it { expect(period.days.count).to eq 2 }
      it { expect(period.full_days.collect(&:id)).to eq [2, nil, nil, nil, nil, nil, nil, 1] }

      it_behaves_like 'full days list has correct length and is sorted'
    end

    context 'when some days have been added' do
      before do
        period.days << build(:day, day_date: Date.today + 5)
        period.days << build(:day, day_date: Date.today + 3)
        period.days << build(:day, day_date: Date.today + 7)
      end

      context 'when period was modified not to include the first day' do
        before { period.update! date_from: Date.today + 4, date_to: Date.today + 11 }

        it { expect(period.days.count).to eq 2 }
        it { expect(period.full_days.collect(&:id)).to eq [nil, 1, nil, 3, nil, nil, nil, nil] }
      end

      context 'when period was modified not to include the last day' do
        before { period.update! date_from: Date.today, date_to: Date.today + 6 }

        it { expect(period.days.count).to eq 2 }
        it { expect(period.full_days.collect(&:id)).to eq [nil, nil, nil, 2, nil, 1, nil] }
      end
    end
  end
end
