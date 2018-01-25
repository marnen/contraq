require 'rails_helper'
require_relative 'decorator_examples'

RSpec.describe PaymentDecorator do
  it_behaves_like 'a decorator'

  context 'decorator methods' do
    let(:params) { {} }
    let(:payment) { FactoryGirl.create :payment, params }
    let(:decorator) { payment.decorate }

    describe '#amount' do
      subject { decorator.amount }

      context 'present in model' do
        it 'returns the amount due, formatted as currency without units' do
          expect(subject).to be == '%.2f' % payment.amount
        end
      end

      context 'not present in model' do
        let(:params) { {amount: nil} }
        it { is_expected.to be_nil }
      end
    end

    describe '#received_at' do
      subject { decorator.received_at }

      it 'returns the received date in DMY format' do
        expect(subject).to be == payment.received_at.strftime('%-d %b %Y')
      end
    end
  end
end
