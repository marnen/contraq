class SubmitCell < Cell::ViewModel
  include Cell::FontAwesome

  def show
    set_options_for_action!
    render
  end

  private

  attr_reader :css_class, :icon_name, :text

  def form
    model
  end

  def set_options_for_action!
    action = options[:action] # always :save
    @css_class = "#{action}-gig"
    @text = _ "#{action.to_s.titleize} gig"
    @icon_name = 'check-circle'
  end
end
