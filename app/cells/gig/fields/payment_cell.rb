class Gig::Fields::PaymentCell < OutputFieldsCell
  private
  css_class 'payment'
  fields amount_due: _('Amount due:'), terms: _('Terms:')
end
