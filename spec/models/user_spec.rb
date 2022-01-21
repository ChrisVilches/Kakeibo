require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'password validation' do
    let(:short_password) { build :user, password: 'a' }
    let(:long_password) { build :user, password: 'zxcvbnm' }

    it { expect(short_password).not_to be_valid }
    it { expect(long_password).to be_valid }
  end
end
