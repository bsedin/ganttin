require 'rails_helper'

module Ganttin
  describe TimeEntry, type: :model do

    context 'should has associations' do
      it { should belong_to :user }
      it { should belong_to :task }
    end

    context 'Created time entry' do
      subject { create(:time_entry) }
      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }
    end
  end
end
