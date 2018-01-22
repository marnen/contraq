module Cell::FontAwesome
  private

  define_method :icon, FontAwesome::Sass::Rails::ViewHelpers.instance_method(:icon)
end
