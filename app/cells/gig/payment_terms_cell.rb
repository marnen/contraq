class Gig::PaymentTermsCell < Cell::ViewModel
  private

  property :amount_due, :terms

  def overdue?
    due_date = model.due_date
    due_date.present? && due_date < Date.today.beginning_of_day
  end
end
