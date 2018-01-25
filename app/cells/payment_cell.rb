class PaymentCell < Cell::ViewModel
  def show
    render
  end

  private

  property :amount, :received_at

  def model
    super.decorate
  end
end
