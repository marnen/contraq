class Gig::PaymentCell < OutputFieldsCell
  def show
    render
  end

  private

  def css_class
    'payment'
  end

  def fields
    {amount_due: _('Amount due:'), terms: _('Terms:')}
  end
end
