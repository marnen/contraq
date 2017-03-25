require 'rails_helper'

describe GigPolicy do
  subject { described_class }

  permissions :update?, :edit? do
    let(:user) { FactoryGirl.create :user }

    context 'own gig' do
      let(:gig) { FactoryGirl.create :gig, user: user }

      it 'grants access' do
        expect(subject).to permit user, gig
      end
    end

    context "someone else's gig" do
      let(:gig) { FactoryGirl.create :gig }

      it 'does not grant access' do
        expect(subject).not_to permit user, gig
      end
    end
  end
end
