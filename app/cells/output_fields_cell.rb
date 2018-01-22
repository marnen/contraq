class OutputFieldsCell < Cell::ViewModel
  class << self
    %i[css_class fields].each do |name|
      define_method name do |value|
        define_method name, -> { value }
        private name
      end
    end
  end

  private

  css_class nil
  fields({})
end
