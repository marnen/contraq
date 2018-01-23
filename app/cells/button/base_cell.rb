class Button::BaseCell < Cell::ViewModel
  def show
    @action = options[:action]
    super
  end

  private

  attr_reader :action

  def css_class
    [action, model_name].join '-'
  end

  def effective_model
    model
  end

  def icon_name
    nil
  end

  def model_name
    effective_model.model_name.human.downcase
  end

  def text
    _ [action.to_s.titleize, model_name].join ' '
  end
end
