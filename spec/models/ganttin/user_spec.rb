require 'rails_helper'

module Ganttin
  describe User, type: :model do
    context 'should has associations' do
      it { should have_many :projects }
      it { should have_many :tasks }
    end

    context 'Created user' do
      subject { create(:user) }
      it { is_expected.to be_valid }
      it { is_expected.to be_persisted }
    end

    context 'Create user with fake email' do
      before { @user = build(:user, email: 'foo@bar') }
      subject { @user }
      it { expect(@user.save).to be_falsey }
      it { is_expected.not_to be_valid }
    end
  end
end
