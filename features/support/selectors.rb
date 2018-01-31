module SelectorHelpers
  def selector_for(selector_name)
    case selector_name
    when /^terms for the gig named "(.+)"$/
      [:xpath,  "//*[@class='payment-terms'][ancestor::*[#{contains_token '@class', 'gig'}]//*[@class='name'][string()='#{$1}']]"]
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

  private

  def contains_token(xpath, token) # TODO: remove when Nokogiri supports XPath >1 so we can use tokenize() (2) or contains-token (3)
    %Q{contains(concat(' ', #{xpath}, ' '), ' #{token} ')}
  end
end

World SelectorHelpers
