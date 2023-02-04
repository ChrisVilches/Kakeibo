require 'rails_helper'

RSpec.describe Mutations::Expenses do
  describe described_class::Destroy do
    let(:context) { { current_user: user } }
    let(:result) do
      KakeiboSchema.execute(query_string, context:, variables:)
    end

    let!(:expense) { create(:expense) }
    let(:variables) { { id: expense.id } }
    let(:query_string) do
      <<-GRAPHQL
      mutation($id: ID!) {
        destroyExpense(input: { id: $id }) {
          id
        }
      }
      GRAPHQL
    end

    context 'when user owns the resource' do
      let(:user) { expense.day.period.user }

      it_behaves_like 'graphql_response_has_no_errors'
      it do
        result
        expect(expense.reload).to be_discarded
      end

      it { expect { result }.to change { Expense.kept.count }.by(-1) }
      it { expect { result }.not_to change(Expense, :count) }
    end

    context 'when user does not own the resource' do
      let(:user) { create(:user) }
      let(:expected_error) { 'not allowed' }

      it_behaves_like 'graphql_response_has_errors'
    end
  end

  describe described_class::Restore do
    let(:context) { { current_user: user } }
    let(:result) do
      KakeiboSchema.execute(query_string, context:, variables:)
    end

    let!(:expense) { create(:expense, :discarded) }
    let(:user) { expense.day.period.user }
    let(:variables) { { id: expense.id, undiscard: true } }
    let(:query_string) do
      <<-GRAPHQL
      mutation($id: ID!) {
        restoreExpense(input: { id: $id }) {
          id
        }
      }
      GRAPHQL
    end

    it_behaves_like 'graphql_response_has_no_errors'

    it { expect { result }.to change { Expense.kept.count }.by(1) }

    it do
      result
      expect(expense.reload).not_to be_discarded
    end
  end
end
