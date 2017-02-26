require 'rails_helper'

describe User do
  describe 'associations' do
    it { is_expected.to have_many :gigs }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
  end
end
