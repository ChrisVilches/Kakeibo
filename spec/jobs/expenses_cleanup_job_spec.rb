require 'rails_helper'

RSpec.describe ExpensesCleanupJob do
  describe '#perform_now' do
    let(:day) { create(:day) }
    let(:now) { DateTime.now }

    before do
      10.times { day.expenses << build(:expense) }
      day.expenses << build(:expense, discarded_at: now - 2.minutes)
      day.expenses << build(:expense, discarded_at: now - 5.minutes)
      day.expenses << build(:expense, discarded_at: now - 7.minutes)
      day.save
    end

    it { expect { described_class.perform_now(minutes: 0) }.to change(Expense, :count).by(-3) }
    it { expect { described_class.perform_now(minutes: 1) }.to change(Expense, :count).by(-3) }
    it { expect { described_class.perform_now(minutes: 2) }.to change(Expense, :count).by(-3) }
    it { expect { described_class.perform_now(minutes: 3) }.to change(Expense, :count).by(-2) }
    it { expect { described_class.perform_now(minutes: 4) }.to change(Expense, :count).by(-2) }
    it { expect { described_class.perform_now(minutes: 5) }.to change(Expense, :count).by(-2) }
    it { expect { described_class.perform_now(minutes: 6) }.to change(Expense, :count).by(-1) }
    it { expect { described_class.perform_now(minutes: 7) }.to change(Expense, :count).by(-1) }
    it { expect { described_class.perform_now(minutes: 8) }.not_to change(Expense, :count) }

    describe '#perform_later' do
      it do
        ActiveJob::Base.queue_adapter = :test
        expect { described_class.perform_later(minutes: 4) }.to have_enqueued_job
      end
    end
  end
end
