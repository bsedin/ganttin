require 'rails_helper'

module Ganttin
  describe TaskStage, type: :model do

    context 'should has associations' do
      it { should belong_to :task }
    end

    context 'Created stage' do
      subject { create(:task_stage) }
      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }
    end
  end
end
