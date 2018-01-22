class Gig::Fields::BasicInfoCell < OutputFieldsCell
  css_class 'basic-info'
  fields(
    start_time: _('Start time:'),
    end_time: _('End time:'),
    location: _('Location:')
  )
end
