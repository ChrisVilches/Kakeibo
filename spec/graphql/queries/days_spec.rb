require 'rails_helper'

RSpec.describe Queries::Days do
  let(:user) { create(:user) }
  let(:context) { { current_user: user } }
  let(:period) do
    user.periods << build(:period)
    user.periods.last
  end

  describe described_class::Show do
    let(:query_string) do
      <<-GRAPHQL
      query($periodId: ID!, $dayDate: ISO8601Date!) {
        fetchOneDay(periodId: $periodId, dayDate: $dayDate) {
          id
          memo
          budget
          expenses {
            id
          }
        }
      }
      GRAPHQL
    end

    let(:day_date_query) { Date.today }
    let(:result) do
      KakeiboSchema.execute(
        query_string,
        context:,
        variables: { periodId: period.id, dayDate: day_date_query.iso8601 }
      )
    end

    let(:result_data) { result.dig 'data', 'fetchOneDay' }

    context 'when day exists' do
      before { period.days << build(:day, day_date: day_date_query) }

      context 'when it has expenses' do
        before { period.days.first.expenses << build(:expense) }

        it { expect(result_data['expenses'].empty?).to be false }
      end

      context 'when it has no expenses' do
        it { expect(result_data['expenses'].empty?).to be true }
      end
    end

    context 'when day does not exist' do
      let(:expected_error) { 'resource was not found' }

      it_behaves_like 'exception_handled_by_graphql'
    end
  end
end
