class CurrentUserCell < Cell::ViewModel
  include H

  def show
    render
  end

  private

  property :email

  def user
    model
  end
end
