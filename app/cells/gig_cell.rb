class GigCell < Cell::ViewModel
  private

  property :name, :time_range, :location

  def fields
    %i[time_range location payment]
  end

  def payment
    cell 'gig/payment', model
  end
end
