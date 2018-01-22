class ButtonCell < Cell::ViewModel
  include Cell::Builder

  builds do |_, options|
    if options[:action] == :save
      Button::SubmitCell
    else
      Button::LinkCell
    end
  end
end
