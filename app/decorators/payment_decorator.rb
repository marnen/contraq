class PaymentDecorator < ApplicationDecorator
  delegate_all

  def amount
    currency super
  end

  def received_at
    super.to_s :dmy
  end
end
