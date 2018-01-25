class PaymentDecorator < ApplicationDecorator
  delegate_all

  def amount
    super ? '%.2f' % super : nil
  end

  def received_at
    super.to_s :dmy
  end
end
