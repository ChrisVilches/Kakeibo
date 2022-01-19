require 'rails_helper'

RSpec.describe 'Periods', type: :request do
  describe 'GET /index' do
    let(:body) { JSON.parse(response.body) }

    context 'when user has no periods' do
      before do
        user = create :user
        login_as user
        get periods_path
      end

      it { expect(response.status).to eq(200) }
      it { expect(body).to eq([]) }
    end

    context 'when user has 3 periods' do
      before do
        user = create :user
        login_as user
        create_list :period, 3, user: user
        get periods_path
      end

      it { expect(response.status).to eq(200) }
      it { expect(body.count).to eq(3) }
    end
  end

  pending 'show'
  pending 'create'
  pending 'destroy'
  pending 'edit_name'
  pending 'edit_times'
end
