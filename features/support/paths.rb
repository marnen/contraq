module PathHelpers
  def path_to(page_name)
    case page_name
    when 'the login page'
      new_user_session_path
    when 'the edit page for the gig'
      edit_gig_path @gig
    when 'the edit page for the payment'
      edit_payment_path @payment
    when /^the gig page for "(.+)"$/
      gig_path Gig.find_by!(name: $1)
    when "the gig's page"
      polymorphic_path @gig
    when 'the gigs page'
      gigs_path
    when 'the new gig page'
      new_gig_path
    when 'the new payment page for the gig'
      new_gig_payment_path @gig
    else
      raise ArgumentError, "No path defined for '#{page_name}'. Please add a mapping in #{__FILE__}."
    end
  end
end

World PathHelpers
