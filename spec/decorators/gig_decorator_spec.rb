require 'rails_helper'

RSpec.describe GigDecorator do
  it 'inherits from ApplicationDecorator' do
    subject = described_class.new Gig.new
    expect(subject).to be_a_kind_of ApplicationDecorator
  end

  describe '#time_range' do
    it 'returns the start and end times for the gig in human-readable format, joined by an en-dash' do
      gig = FactoryGirl.create(:gig) do |gig|
        gig.end_time = gig.start_time + rand(2..5).hours
      end.decorate
      expect(gig.time_range).to be == [gig.start_time, gig.end_time].map {|time| time.strftime '%-d %b %Y %-l:%M %p' }.join('–')
    end
  end
end
