require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'password validation' do
    let(:short_password) { build :user, password: 'a' }
    let(:long_password) { build :user, password: 'zxcvbnm' }

    it { expect(short_password.valid?).to be_falsey }
    it { expect(long_password.valid?).to be_truthy }
  end
end
