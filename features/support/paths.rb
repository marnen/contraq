module PathHelpers
  def path_to(page_name)
    case page_name
    when 'the login page'
      new_user_session_path
    when 'the new gig page'
      new_gig_path
    when 'the gigs page'
      gigs_path
    else
      raise ArgumentError, "No path defined for '#{page_name}'. Please add a mapping in #{__FILE__}."
    end
  end
end

World PathHelpers
