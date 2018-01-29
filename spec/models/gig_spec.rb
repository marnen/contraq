require 'rails_helper'

describe Gig do
  describe 'associations' do
    it { is_expected.to have_many :payments }
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :start_time }
    it { is_expected.to validate_presence_of :end_time }
    it { is_expected.to validate_presence_of :user_id }
  end

  describe '.permitted_params' do
    it 'returns all the column names, except time stamps' do
      expected_column_names = Gig.column_names - [:created_at, :updated_at]
      expect(Gig.permitted_params).to match expected_column_names
    end
  end

  describe '#due_date' do
    let(:gig) { FactoryGirl.create :gig, params }
    let(:params) { {} }

    subject { gig.due_date }

    context 'terms and start time are present' do
      it "returns the start date plus as many days as terms specifies" do
        expect(subject).to be == gig.start_time.advance(days: gig.terms)
      end
    end

    context 'terms is not present' do
      let(:params) { {terms: nil} }
      it { is_expected.to be_nil }
    end
  end
end
