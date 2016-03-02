require 'rails_helper'

describe Gig do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :start_time }
  it { is_expected.to validate_presence_of :end_time }
end
