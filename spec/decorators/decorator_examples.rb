RSpec.shared_examples_for 'a decorator' do
  it 'inherits from ApplicationDecorator' do
    subject = described_class.new({})
    expect(subject).to be_a_kind_of ApplicationDecorator
  end
end
