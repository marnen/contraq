class GigPolicy < ApplicationPolicy
  def update?
    gig.user == user
  end

  class Scope < Scope
    def resolve
      scope.where user: user
    end
  end

  private

  def gig
    record
  end
end
