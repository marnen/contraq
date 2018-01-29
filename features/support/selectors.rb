module SelectorHelpers
  def selector_for(selector_name)
    case selector_name
    when /^terms for the gig named "(.+)"$/
      [:xpath,  "//*[@class='payment-terms'][ancestor::*[@class='gig']//*[@class='name'][string()='#{$1}']]"]
    when /^the "(.+)" field$/
      [:field, $1]
    when 'the gig'
      ".gig#gig_#{@gig.id}"
    when "the gig's payments"
      [selector_for('the gig'), '.payments'].join ' '
    when 'the payment'
      ".payment#payment_#{@payment.id}"
    else
      raise ArgumentError, "No selector defined for '#{selector_name}'. Please add a mapping in #{__FILE__}."
    end
  end
end

World SelectorHelpers
