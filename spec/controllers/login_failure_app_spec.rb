require 'rails_helper'

RSpec.describe LoginFailureApp do
  let(:instance) { described_class.new }

  describe '#status_code' do
    subject { instance.send :status_code }

    before { allow(instance).to receive(:params).and_return(request_params) }

    context 'when request is graphql' do
      let(:request_params) { { graphql: {} } }

      it { is_expected.to eq 200 }
    end

    context 'when request is not graphql' do
      let(:request_params) { { some_data: {} } }

      it { is_expected.to eq 401 }
    end
  end

  describe '#graphql_request?' do
    subject { instance.send :graphql_request? }

    before { allow(instance).to receive(:params).and_return(request_params) }

    context 'when it is a graphql query' do
      let(:request_params) { { graphql: {} } }

      it { is_expected.to be true }
    end

    context 'when it is not a graphql query' do
      let(:request_params) { { some_data: {} } }

      it { is_expected.to be false }
    end
  end

  describe '#error_code' do
    subject { instance.send :error_code }

    before { allow(instance).to receive(:i18n_message).and_return(message) }

    context 'when the message contains the word expired' do
      let(:message) { 'Session has Expired' }

      it { is_expected.to eq :SIGNATURE_EXPIRED }
    end

    context 'when the message does not contain the word expired' do
      let(:message) { 'Something else happened' }

      it { is_expected.to eq :NOT_LOGGED_IN }
    end
  end

  describe '#json_rest' do
    subject { instance.send :json_rest }

    before { allow(instance).to receive(:i18n_message).and_return('some expired error') }

    it { is_expected.to eq({ message: 'some expired error', code: :SIGNATURE_EXPIRED }) }
  end

  describe '#json_graphql' do
    subject { instance.send :json_graphql }

    let(:expected_result) do
      {
        data: nil,
        errors: [
          { message: 'some random error', extensions: { code: :NOT_LOGGED_IN } }
        ]
      }
    end

    before { allow(instance).to receive(:i18n_message).and_return('some random error') }

    it { is_expected.to eq expected_result }
  end
end
