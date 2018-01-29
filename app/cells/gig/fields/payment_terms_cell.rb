class Gig::Fields::PaymentTermsCell < Cell::ViewModel
  private

  property :terms

  # TODO: unify with PaymentTermsCell
  def overdue?
    due_date = model.due_date
    due_date.present? && due_date < Date.today.beginning_of_day
  end
end
