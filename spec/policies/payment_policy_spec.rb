require 'rails_helper'

describe PaymentPolicy do
  let(:user) { FactoryGirl.create :user }
  subject { described_class }

  permissions :update?, :edit? do
    # TODO: consider extracting some shared examples since a lot of this duplicates the spec for GigPolicy
    let(:gig_params) { {} }
    let(:gig) { FactoryGirl.create :gig, gig_params }
    let(:payment) { FactoryGirl.create :payment, gig: gig }

    context 'own gig' do
      let(:gig_params) { super().merge user: user }

      it 'grants access' do
        expect(subject).to permit user, payment
      end
    end

    context "someone else's gig" do
      it 'does not grant access' do
        expect(subject).not_to permit user, payment
      end
    end
  end
end
