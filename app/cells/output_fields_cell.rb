class OutputFieldsCell < Cell::ViewModel
  class << self
    def css_class(string = nil, &block)
      block = string ? -> { string } : block
      define_method :css_class, block
    end

    def fields(hash = nil, &block)
      block = hash ? -> { hash } : block
      define_method :fields, block
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
