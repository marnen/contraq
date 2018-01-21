require 'rails_helper'

RSpec.describe GigDecorator do
  it 'inherits from ApplicationDecorator' do
    subject = described_class.new Gig.new
    expect(subject).to be_a_kind_of ApplicationDecorator
  end

  context 'decorator methods' do
    let(:gig) { FactoryGirl.create :gig, params, &block_params }
    let(:params) { {} }
    let(:block_params) { ->(gig) { } }
    let(:decorator) { gig.decorate }

    describe '#location' do
      subject { decorator.location }

      context 'both city and state present' do
        it 'returns the city and state, comma-separated' do
          expect(subject).to be == "#{gig.city}, #{gig.state}"
        end
      end

      context 'no city' do
        let(:params) { {city: nil} }

        it 'returns the state only' do
          expect(subject).to be == gig.state
        end
      end

      context 'no state' do
        let(:params) { {state: nil} }

        it 'returns the city only' do
          expect(subject).to be == gig.city
        end
      end
    end

    describe '#time_range' do
      let(:block_params) { ->(gig) { gig.end_time = gig.start_time + rand(2..5).hours } }
      let(:subject) { decorator.time_range }

      it 'returns the start and end times for the gig in human-readable format, joined by an en-dash' do
        expect(subject).to be == [gig.start_time, gig.end_time].map {|time| time.strftime '%-d %b %Y %-l:%M %p' }.join('–')
      end
    end
  end
end
