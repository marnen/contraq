class OutputFieldCell < Cell::ViewModel
  def show
    render
  end

  private

  [:method, :name].each do |key|
    define_method(key) { options[key] }
  end
end
