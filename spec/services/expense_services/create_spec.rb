require 'rails_helper'

RSpec.describe ExpenseServices::Create do
  let(:user) { create :user }
  let(:period) do
    user.periods << build(:period)
    user.periods.last
  end

  let(:day_date) { Date.today }
  let(:service) { described_class.new(user) }

  describe '#execute' do
    context 'when day does not exist' do
      it 'creates a new expense' do
        expect do
          service.execute(period_id: period.id, day_date: day_date, cost: 11, label: 'yes')
        end.to change(Expense, :count).by 1
      end

      it 'creates a new day' do
        expect do
          service.execute(period_id: period.id, day_date: day_date, cost: 11, label: 'yes')
        end.to change(Day, :count).by 1
      end
    end

    context 'when day exists' do
      before { period.days << build(:day, day_date: day_date) }

      it 'creates a new expense' do
        expect do
          service.execute(period_id: period.id, day_date: day_date, cost: 11, label: 'yes')
        end.to change(Expense, :count).by 1
      end

      it 'does not create a new day' do
        expect do
          service.execute(period_id: period.id, day_date: day_date, cost: 11, label: 'yes')
        end.not_to change(Day, :count)
      end
    end
  end
end
