class Button::BaseCell < Cell::ViewModel
  def show
    @action = options[:action]
    super
  end

  private

  attr_reader :action

  def css_class
    [:button, *(options[:class] || [action, model_name])]
  end

  def effective_model
    Array(model).last
  end

  def icon_name
    options[:icon]
  end

  def model_name
    effective_model.model_name.human.downcase
  end

  def text
    options[:text] || _([action.to_s.titleize, model_name].join ' ')
  end
end
