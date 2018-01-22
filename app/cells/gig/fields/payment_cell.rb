class Gig::Fields::PaymentCell < OutputFieldsCell
  private

  def css_class
    'payment'
  end

  def fields
    {amount_due: _('Amount due:'), terms: _('Terms:')}
  end
end
