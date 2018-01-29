class Gig::PaymentTermsCell < Cell::ViewModel
  private
  property :amount_due, :overdue?, :terms
end
