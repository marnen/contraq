class CurrentUserCell < Cell::ViewModel
  include ERB::Util

  def show
    render
  end

  private

  property :email

  def user
    model
  end
end
