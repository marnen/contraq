class Gig::Fields::PaymentCell < OutputFieldsCell
  css_class 'payment'
  fields amount_due: _('Amount due:'), terms: _('Terms:')
end
