class GigCell < Cell::ViewModel
  def show
    render
  end

  private

  property :name, :time_range, :location
end
