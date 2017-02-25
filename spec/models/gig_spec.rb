require 'rails_helper'

describe Gig do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :start_time }
  it { is_expected.to validate_presence_of :end_time }

  describe '.permitted_params' do
    it 'returns all the column names, except time stamps' do
      expected_column_names = Gig.column_names - [:created_at, :updated_at]
      expect(Gig.permitted_params).to match expected_column_names
    end
  end
end
