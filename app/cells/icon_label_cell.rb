class IconLabelCell < Cell::ViewModel
  include Cell::FontAwesome

  private

  def icon_name
    options[:icon]
  end

  def text
    model
  end
end
