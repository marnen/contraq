class CurrentUserCell < Cell::ViewModel
  include H

  private

  property :email

  def user
    model
  end
end
