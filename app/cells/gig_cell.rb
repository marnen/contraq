class GigCell < Cell::ViewModel
  private

  property :name, :time_range, :location

  def fields
    %i[time_range location payment_terms]
  end

  def payment_terms
    cell 'gig/payment_terms', model
  end

  def payments
    model.payments.order :received_at
  end
end
