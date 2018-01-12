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

  def time_range
    [start_time, end_time].map {|time| time.strftime time_format }.join '–'
  end

  private

  def time_format
    '%-d %b %Y %-l:%M %p'
  end
end
