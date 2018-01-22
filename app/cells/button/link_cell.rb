class Button::LinkCell < Cell::ViewModel
  include Cell::FontAwesome

  def show
    set_options_for_action!
    render
  end

  private

  attr_reader :css_class, :icon_name, :link_options, :text

  def set_options_for_action!
    action = options[:action]
    @css_class = "#{action}-gig"
    @text = _ "#{action.to_s.titleize} gig"
    case action
    when :edit
      @icon_name = 'pencil'
      @link_options = edit_gig_path(model)
    when :new
      @icon_name = 'plus-circle'
      @link_options = {action: 'new'}
    end
  end
end
