class OutputFieldsCell < Cell::ViewModel
  class << self
    %i[css_class fields].each do |name|
      define_method name do |value|
        define_method name, -> { value }
      end
    end
  end

  private

  def css_class
    nil
  end

  def fields
    {}
  end
end
