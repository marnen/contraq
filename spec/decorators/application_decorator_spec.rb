require 'rails_helper'

RSpec.describe ApplicationDecorator do
  let(:wrapped) { {} }
  let(:decorator) { described_class.new wrapped }

  it 'is a Draper decorator' do
    expect(decorator).to be_a_kind_of Draper::Decorator
  end

  describe '#currency' do
    subject { decorator.currency amount }

    context 'amount is present' do
      let(:amount) { rand(100000) / 1000.0 }

      it 'returns the amount formatted as currency without units' do
        expect(subject).to be == '%.2f' % amount
      end
    end

    context 'amount is nil' do
      let(:amount) { nil }
      it { is_expected.to be_nil }
    end
  end

  describe '#haml_object_ref' do
    let(:wrapped) { klass.new }
    subject { decorator.haml_object_ref }

    context 'wrapped object defines haml_object_ref' do
      let(:object_ref) { Faker::Lorem.words(2).join '_' }
      let(:klass) do
        Class.new.tap do |klass|
          # TODO: can we do this with a block instead of a string?
          klass.class_eval <<-"RUBY"
            def haml_object_ref
              '#{object_ref}'
            end
          RUBY
        end
      end

      it 'delegates to the wrapped object' do
        expect(subject).to be == wrapped.haml_object_ref
      end
    end

    context 'wrapped object does not define haml_object_ref' do
      let(:klass) { Gig }

      it 'returns the class name of the wrapped object in underscore_case' do
        expect(subject).to be == wrapped.class.name.underscore
      end
    end
  end
end
