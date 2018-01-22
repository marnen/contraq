class Gig::PaymentCell < Cell::ViewModel
  def show
    render
  end

  private

  property :amount_due, :terms
end
