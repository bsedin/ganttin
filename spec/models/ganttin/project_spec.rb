require 'rails_helper'

module Ganttin
  describe Project, type: :model do

    context 'should has associations' do
      it { should have_many :tasks }
      it { should have_many :members }
    end

    context 'Created project' do
      subject { create(:project)}
      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }
    end
  end
end
