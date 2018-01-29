class Gig::Fields::PaymentTermsCell < Cell::ViewModel
  private

  def fields
    {amount_due: _('Amount due:'), terms: _('Terms:')}
  end
end
