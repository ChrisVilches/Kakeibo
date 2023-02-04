require 'rails_helper'

shared_examples 'signed out successfully message' do
  it { expect(response[:json][:message]).to eq 'Signed out successfully.' }
end

shared_examples 'status ok' do
  it { expect(response[:status]).to eq :ok }
end

shared_examples 'status unauthorized' do
  it { expect(response[:status]).to eq :unauthorized }
end

RSpec.describe Users::SessionsController do
  let(:controller_instance) { described_class.new }
  let(:user) { nil }

  before do
    allow(controller_instance).to receive(:render) { |arg| arg }
    allow(controller_instance).to receive(:current_user).and_return user
  end

  describe '#log_out_success' do
    let(:response) { controller_instance.send :log_out_success }

    it_behaves_like 'signed out successfully message'
    it_behaves_like 'status ok'
  end

  describe '#log_out_failure' do
    let(:response) { controller_instance.send :log_out_failure }

    it_behaves_like 'signed out successfully message'
    it_behaves_like 'status unauthorized'
  end

  describe '#respond_to_on_destroy' do
    let(:response) { controller_instance.send :respond_to_on_destroy }

    context 'when logged in' do
      let(:user) { create(:user) }

      it_behaves_like 'signed out successfully message'
      it_behaves_like 'status ok'
    end

    context 'when not logged in' do
      it_behaves_like 'signed out successfully message'
      it_behaves_like 'status unauthorized'
    end
  end

  describe '#respond_with' do
    let(:response) { controller_instance.send :respond_with, resource }

    context 'with correct user' do
      let(:resource) { create(:user) }

      it { expect(response[:json][:message]).to eq 'Signed in successfully.' }

      it_behaves_like 'status ok'
    end

    context 'without correct user' do
      let(:resource) { build(:user) }

      it do
        expect(response[:json][:message]).to eq 'You need to sign in or sign up before continuing.'
      end

      it_behaves_like 'status unauthorized'
    end
  end
end
