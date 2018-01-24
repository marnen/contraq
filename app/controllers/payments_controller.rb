class PaymentsController < ApplicationController
  # TODO: add authorization (probably with Resourceful).

  before_action :authenticate_user!

  def new
    session[:previous_url] = request.headers['referer']
    @payment = Payment.new gig_id: params[:gig_id], received_at: Time.zone.today
  end

  def create
    @payment = Payment.create! params.require(:payment).permit(Payment.permitted_params).merge(gig_id: params[:gig_id])
    redirect_to(session.delete(:previous_url) || gigs_path)
  end
end
