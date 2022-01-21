require 'rails_helper'

RSpec.describe DayServices::Upsert do
  let(:user) { create :user }
  let(:period) do
    user.periods << build(:period)
    user.periods.last
  end

  let(:day_date) { Date.today }
  let(:service) { described_class.new(user) }

  describe '#execute' do
    context 'when day does not exist' do
      it 'creates a new one' do
        expect do
          service.execute(period_id: period.id, day_date:, memo: 'good morning')
        end.to change(Day, :count).by 1
      end

      it do
        service.execute(period_id: period.id, day_date:, memo: 'good morning')
        expect(period.days.first.memo).to eq 'good morning'
      end
    end

    context 'when day exists' do
      before { period.days << build(:day, day_date:, memo: 'hello') }

      it { expect(period.days.first.memo).to eq 'hello' }

      it 'does not create a new one' do
        expect do
          service.execute(period_id: period.id, day_date:, memo: 'bye')
        end.not_to change(Day, :count)
      end

      it do
        service.execute(period_id: period.id, day_date:, memo: 'bye')
        expect(period.days.first.memo).to eq 'bye'
      end
    end
  end
end
