shared_examples 'graphql_response_has_errors' do
  it { expect(result['errors']&.dig(0, 'message')).to eq expected_error }
  it { expect(result['data'].blank?).to be true }
end

shared_examples 'graphql_response_has_no_errors' do
  it { expect(result['errors'].blank?).to be true }
  it { expect(result['data'].present?).to be true }
end

shared_examples 'exception_handled_by_graphql' do
  it 'handles the exception using GraphQL exception handler' do
    expect { result }.not_to raise_error
  end

  it_behaves_like 'graphql_response_has_errors'
end
