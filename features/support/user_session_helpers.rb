module UserSessionHelpers
  def login_as(email:, password:)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'
  end

  def logout
    page.driver.submit :delete, destroy_user_session_path, {}
  end
end

World UserSessionHelpers
