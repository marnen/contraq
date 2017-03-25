class GigPolicy < ApplicationPolicy
  def update?
    gig.user == user
  end

  private

  def gig
    record
  end
end
