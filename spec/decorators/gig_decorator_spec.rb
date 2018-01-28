require 'rails_helper'
require_relative 'decorator_examples'

RSpec.describe GigDecorator do
  it_behaves_like 'a decorator'

  context 'decorator methods' do
    let(:gig) { FactoryGirl.create :gig, params, &block_params }
    let(:params) { {} }
    let(:block_params) { ->(gig) { } }
    let(:decorator) { gig.decorate }

    context 'date and time' do
      let(:datetime_format) { '%-d %b %Y %-l:%M %p' }

      shared_examples_for 'a date presenter' do
        subject { decorator.public_send method_name }

        it "returns the model's time property as a string" do
          expect(subject).to be == gig.public_send(method_name).strftime(datetime_format)
        end
      end

      describe '#end_time' do
        let(:method_name) { :end_time }
        it_behaves_like 'a date presenter'
      end

      describe '#start_time' do
        let(:method_name) { :start_time }
        it_behaves_like 'a date presenter'
      end

      describe '#time_range' do
        let(:block_params) { ->(gig) { gig.end_time = gig.start_time + rand(2..5).hours } }
        let(:subject) { decorator.time_range }

        it 'returns the start and end times for the gig in human-readable format, joined by an en-dash' do
          expect(subject).to be == [gig.start_time, gig.end_time].map {|time| time.strftime datetime_format }.join('–')
        end
      end
    end

    describe '#amount_due' do
      subject { decorator.amount_due }

      context 'present in model' do
        it 'returns the amount due, formatted as currency without units' do
          expect(subject).to be == '%.2f' % gig.amount_due
        end
      end

      context 'not present in model' do
        let(:params) { {amount_due: nil} }
        it { is_expected.to be_nil }
      end
    end

    describe '#due_date' do
      subject { decorator.due_date }

      context 'terms and start time are present' do
        it "returns the start date plus as many days as terms specifies, formatted as a date" do
          expect(subject).to be == gig.start_time.advance(days: gig.terms).to_s(:dmy)
        end
      end

      context 'terms is not present' do
        let(:params) { {terms: nil} }
        it { is_expected.to be_nil }
      end
    end

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

    describe '#terms' do
      let(:block_params) { ->(gig) { gig.end_time = gig.start_time + rand(2..5).days } }
      let(:terms) { rand(1..120) }
      let(:params) { {terms: terms} }
      subject { decorator.terms }

      context 'present in model' do
        let(:expected_date_string) { gig.start_time.advance(days: gig.terms).to_s :dmy }

        context 'greater than 1' do
          let(:terms) { rand(2..120) }

          it 'returns a count of days from start date to due date, followed by the due date in parentheses' do
            expect(subject).to be == "#{gig.terms} days (#{expected_date_string})"
          end
        end

        context '1' do
          let(:terms) { 1 }

          it 'behaves as for greater than 1, but "day" is singular' do
            expect(subject).to be == "1 day (#{expected_date_string})"
          end
        end

        it 'uses i18n for the pluralization' do
          # TODO: do we really have to do it this way?
          expect(decorator.helpers).to receive(:n_).with('1 day', a_string_matching(/^%\S+ days$/), anything).and_call_original
          subject
        end
      end

      context 'not present in model' do
        let(:terms) { nil }
        it { is_expected.to be_nil }
      end
    end
  end
end
