class PaymentPolicy < ApplicationPolicy
  def update?
    Pundit.policy!(user, gig).update?
  end

  private

  def gig
    payment.gig
  end

  def payment
    record
  end
end
