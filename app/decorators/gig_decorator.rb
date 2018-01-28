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

  def amount_due
    currency super
  end

  def due_date
    model.terms.present? ? model.start_time.advance(days: model.terms).to_s(:dmy) : nil
  end

  def end_time
    super.to_s :datetime
  end

  def location
    [model.city, model.state].compact.join _(', ')
  end

  def start_time
    super.to_s :datetime
  end

  def terms
    if super
      [
        h.n_('1 day', '%{count} days', super) % {count: super},
        "(#{model.start_time.advance(days: super).to_s(:dmy)})"
      ].join ' '
    end
  end

  def time_range
    [model.start_time, model.end_time].map {|time| time.strftime Time::DATE_FORMATS[:datetime] }.join '–'
  end
end
