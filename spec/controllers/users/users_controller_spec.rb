require 'rails_helper'

RSpec.describe Users::UsersController, type: :controller do
  let(:user) { create :user }
  let(:hash_res) { JSON.parse(response.body).symbolize_keys }

  describe 'GET /me' do
    context 'when the user is logged in' do
      before do
        sign_in user
        get :me
      end

      it { expect(response).to have_http_status :ok }
      it { expect(hash_res.keys).to eq %i[id email created_at updated_at] }
    end

    context 'when the user is not logged in' do
      before { get :me }

      it { expect(response).to have_http_status :unauthorized }

      it { expect(hash_res.keys).to eq %i[message code] }
      it { expect(hash_res[:message]).to eq 'You need to sign in or sign up before continuing.' }
      it { expect(hash_res[:code]).to eq 'NOT_LOGGED_IN' }
    end
  end
end
