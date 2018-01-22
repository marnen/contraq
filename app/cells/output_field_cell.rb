class OutputFieldCell < Cell::ViewModel
  private

  [:method, :name].each do |key|
    define_method(key) { options[key] }
  end
end
