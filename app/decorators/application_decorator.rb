class ApplicationDecorator < Draper::Decorator
  def currency(amount)
    amount ? '%.2f' % amount : nil
  end

  def haml_object_ref
    model.haml_object_ref
  rescue NoMethodError
    model.class.name.underscore
  end
end
