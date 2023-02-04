require 'rails_helper'

RSpec.describe User do
  describe 'password validation' do
    let(:short_password) { build(:user, password: 'a') }
    let(:long_password) { build(:user, password: 'zxcvbnm') }

    it { expect(short_password).not_to be_valid }
    it { expect(long_password).to be_valid }
  end

  describe '#periods' do
    let(:user) { create(:user) }

    before do
      user.periods << build(:period, name: 'a', date_from: DateTime.now - 10, date_to: DateTime.now)
      user.periods << build(:period, name: 'b', date_from: DateTime.now - 20, date_to: DateTime.now)
    end

    it { expect(user.periods.count).to eq 2 }

    it 'sorts periods by date_from ASC (first one has lower date_from)' do
      expect(user.periods.first.name).to eq 'b'
    end

    it 'sorts periods by date_from ASC (last one has higher date_from)' do
      expect(user.periods.last.name).to eq 'a'
    end
  end
end
