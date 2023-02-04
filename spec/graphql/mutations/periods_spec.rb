require 'rails_helper'

INT_MAX = (1 << 31) - 1

RSpec.describe Mutations::Periods do
  let(:user) { create(:user) }
  let(:context) { { current_user: user } }

  before { user.periods << build(:period) }

  describe described_class::Update do
    let(:query_string) do
      <<-GRAPHQL
      mutation($id: ID!, $numericValue: Int!) {
        updatePeriod(input: {
        id: $id,
        salary: $numericValue,
        initialMoney: $numericValue,
        dailyExpenses: $numericValue
        }) {
          id
        }
      }
      GRAPHQL
    end

    let(:result) do
      KakeiboSchema.execute(
        query_string,
        context:,
        variables: {
          id: user.periods.first.id,
          numericValue: numeric_value,
          dailyExpenses: numeric_value
        }
      )
    end

    context 'when number is too large (> signed 32-bit int max value)' do
      let(:expected_error) { 'Variable $numericValue of type Int! was provided invalid value' }
      let(:numeric_value) { INT_MAX + 1 }

      it_behaves_like 'graphql_response_has_errors'
    end

    context 'when number is within correct range (signed 32-bit int)' do
      let(:numeric_value) { INT_MAX }

      it_behaves_like 'graphql_response_has_no_errors'
    end
  end
end
