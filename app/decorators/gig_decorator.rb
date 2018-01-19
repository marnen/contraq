class GigDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def location
    [model.city, model.state].compact.join _(', ')
  end

  def time_range
    [model.start_time, model.end_time].map {|time| time.strftime Time::DATE_FORMATS[:datetime] }.join '–'
  end
end
