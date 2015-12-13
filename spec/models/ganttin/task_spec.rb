require 'rails_helper'

module Ganttin
  describe Task, type: :model do
    context 'should has associations' do
      it { should have_many :members }
      it { should have_many :time_entries }
    end

    context 'Created task' do
      subject { create(:task)}
      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }
    end
  end
end
