class Button::BaseCell < Cell::ViewModel
  def show
    @action = options[:action]
    super
  end

  private

  attr_reader :action

  def css_class
    "#{action}-gig"
  end

  def icon_name
    nil
  end

  def text
    _ "#{action.to_s.titleize} gig"
  end
end
