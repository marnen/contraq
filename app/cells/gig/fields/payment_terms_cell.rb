class Gig::Fields::PaymentTermsCell < OutputFieldsCell
  css_class 'payment-terms'
  fields amount_due: _('Amount due:'), terms: _('Terms:')
end
