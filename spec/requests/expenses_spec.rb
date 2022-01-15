require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  let(:user1) { create :user }
  let(:user2) { create :user }
  let(:period) { create :period, user: user1 }
  let(:day) { create :day, period: period }
  let!(:expense) { create :expense, day: day }

  describe 'PUT /periods/:period_id/expenses/:day_date' do
    before { login_as user1 }

    context 'when the day row already exists' do
      it do
        expect do
          put "/periods/#{period.id}/expenses/#{day.day_date}",
              params: { expense: { label: 'dinner', cost: 123_123 } }
        end.to change(Expense, :count).by(1)
      end
    end

    context 'when the day row does not already exist' do
      it do
        expect do
          put "/periods/#{period.id}/expenses/#{day.day_date + 1}",
              params: { expense: { label: 'dinner', cost: 123_123 } }
        end.to change(Expense, :count).by(1)
                                      .and change(Day, :count).by(1)
      end
    end
  end

  describe 'DELETE /expenses/:id' do
    context 'when the user owns the expense' do
      before { login_as user1 }

      it { expect { delete expense_path(expense) }.to change(Expense, :count).by(-1) }
    end

    context 'when the user does not own the expense' do
      before { login_as user2 }

      it { expect { delete expense_path(expense) }.to raise_error(Pundit::NotAuthorizedError) }
    end
  end
end
