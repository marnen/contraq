class Gig::Fields::BasicInfoCell < Cell::ViewModel
  private

  def fields
    {
      start_time: _('Start time:'),
      end_time: _('End time:'),
      location: _('Location:')
    }
  end
end
