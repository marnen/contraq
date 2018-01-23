class PaymentCell < Cell::ViewModel
  def show
    render
  end

  private

  def amount
    '%.2f' % model.amount
  end

  def received_at
    model.received_at.to_s :dmy
  end
end
