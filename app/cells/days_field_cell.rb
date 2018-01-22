class DaysFieldCell < Cell::ViewModel
  include ERB::Util

  private

  def name
    options[:name]
  end

  def form
    model
  end
end
