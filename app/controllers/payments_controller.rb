class PaymentsController < ApplicationController
  # TODO: add authorization (probably with Resourceful).

  before_action :authenticate_user!

  def new
    @payment = Payment.new gig_id: params[:gig_id], received_at: Time.zone.today
  end

  def create
    @payment = Payment.create! params.require(:payment).permit(Payment.permitted_params).merge(gig_id: params[:gig_id])
    redirect_to gigs_path and return
  end
end
