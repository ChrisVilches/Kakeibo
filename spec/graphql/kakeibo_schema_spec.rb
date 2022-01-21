require 'rails_helper'

RSpec.describe KakeiboSchema do
  let(:user) { create :user }
  let(:result) { described_class.execute(query_string, context: { current_user: user }) }

  before { user.periods << build(:period) }

  describe "rescue_from #{ActiveRecord::RecordInvalid}" do
    let(:query_string) do
      <<-GRAPHQL
      mutation {
        updatePeriod(input: {id: 1, dateFrom: "2022-11-21", dateTo: "2022-11-20"}) {
          id
          dateTo
          dateFrom
        }
      }
      GRAPHQL
    end

    context 'when query contains an object that throws validation errors' do
      let(:expected_error) do
        [
          'Validation failed: initial date must be before finish date',
          'period length cannot be shorter than 7 days'
        ].join(', ')
      end

      it_behaves_like 'graphql_response_has_errors'
    end
  end

  describe "rescue_from #{Pundit::NotAuthorizedError}" do
    let(:another_user) { create :user }
    let(:query_string) do
      <<-GRAPHQL
      mutation  {
        destroyExpense(input: { id: 1 }) {
          cost
        }
      }
      GRAPHQL
    end

    before do
      another_user.periods << build(:period)
      period = another_user.periods.first
      period.days << build(:day)
      period.days.first.expenses << build(:expense)
    end

    context 'when query modifies a resource the user does not own' do
      let(:expected_error) { 'not allowed' }

      it_behaves_like 'graphql_response_has_errors'
    end
  end
end
