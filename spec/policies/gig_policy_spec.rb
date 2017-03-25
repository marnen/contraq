require 'rails_helper'

describe GigPolicy do
  let(:user) { FactoryGirl.create :user }
  subject { described_class }

  permissions :update?, :edit? do
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

  describe '#scope' do
    let(:gig) { Gig.new }
    subject { described_class.new(user, gig).scope }

    it "resolves to the user's gigs" do
      expected_gigs = FactoryGirl.create_list :gig, rand(3..5), user: user
      other_gig = FactoryGirl.create :gig

      expect(subject.all).to match_array expected_gigs
    end
  end
end
