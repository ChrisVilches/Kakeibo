require 'rails_helper'

RSpec.describe Queries::Periods do
  let(:user) { create :user }
  let(:context) { { current_user: user } }

  describe described_class::List do
    let(:query_string) do
      <<-GRAPHQL
      {
        fetchPeriods {
          id
        }
      }
      GRAPHQL
    end
    let(:result) { KakeiboSchema.execute(query_string, context: context)['data']['fetchPeriods'] }

    context 'without periods' do
      it { expect(result).to eq [] }
    end

    context 'with periods' do
      before { user.periods << build(:period) }

      it { expect(result.count).to eq 1 }
    end
  end

  describe described_class::Show do
    let(:query_string) do
      <<-GRAPHQL
      query FetchOnePeriod($id: ID!) {
        fetchOnePeriod(id: $id) {
          id
          name
          days {
            id
          }
        }
      }
      GRAPHQL
    end
    let(:result) do
      KakeiboSchema.execute(
        query_string,
        context: context,
        variables: { id: 1 }
      )['data']['fetchOnePeriod']
    end

    context 'without periods' do
      it { expect { result }.to raise_error ActiveRecord::RecordNotFound }
    end

    context 'with periods' do
      before { user.periods << build(:period) }

      context 'without days' do
        it { expect(result.present?).to be_truthy }
        it { expect(result['days']).to eq [] }
      end

      context 'with days' do
        before do
          period = user.periods.first
          [period.date_from, period.date_to].each { |d| period.days << build(:day, day_date: d) }
        end

        it { expect(result.present?).to be_truthy }
        it { expect(result['days'].count).to eq 2 }
      end
    end
  end
end
