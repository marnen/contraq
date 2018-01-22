class Gig::Fields::BasicInfoCell < OutputFieldsCell

  def show
    render
  end

  private

  def css_class
    'basic-info'
  end

  def fields
    {
      start_time: _('Start time:'),
      end_time: _('End time:'),
      location: _('Location:')
    }
  end
end
