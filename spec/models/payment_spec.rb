require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { is_expected.to belong_to :gig }
  it { is_expected.to validate_presence_of :gig_id }

  describe '.permitted_params' do
    # TODO: refactor to shared examples
    it 'returns all the column names, except time stamps and gig ID' do
      expected_column_names = Payment.column_names - [:created_at, :updated_at, :gig_id]
      expect(Payment.permitted_params).to match expected_column_names
    end
  end
end
