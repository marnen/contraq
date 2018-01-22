class DaysFieldCell < Cell::ViewModel
  include ERB::Util

  def show
    render
  end

  private

  def name
    options[:name]
  end

  def form
    model
  end
end
