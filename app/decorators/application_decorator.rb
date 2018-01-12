class ApplicationDecorator < Draper::Decorator
  def haml_object_ref
    model.haml_object_ref
  rescue NoMethodError
    model.class.name.underscore
  end
end
