class Gig::PaymentsCell < Cell::ViewModel
  def show
    @payments = model.payments
    render
  end

  private

  attr_reader :payments
end
