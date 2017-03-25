require 'rails_helper'

describe GigPolicy do
  let(:user) { double 'User' }
  let(:gig) { double 'Gig' }
  let(:policy) { GigPolicy.new user, gig }
  subject { policy }

  it { is_expected.to be_a_kind_of ApplicationPolicy }

  describe '#update?' do
    let(:user) { FactoryGirl.create :user }
    subject { policy.update? }

    context 'own gig' do
      let(:gig) { FactoryGirl.create :gig, user: user }

      it { is_expected.to be true }
    end

    context "someone else's gig" do
      let(:gig) { FactoryGirl.create :gig }

      it { is_expected.to be false }
    end
  end
end
