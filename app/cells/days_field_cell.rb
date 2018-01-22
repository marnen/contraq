class DaysFieldCell < Cell::ViewModel
  include H

  private

  def name
    options[:name]
  end

  def form
    model
  end
end
