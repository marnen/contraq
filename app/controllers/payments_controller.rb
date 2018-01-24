class PaymentsController < ApplicationController
  include Resourceful

  before_action :authenticate_user!
  before_action :load_and_authorize_gig!

  def new
    session[:previous_url] = request.headers['referer']
    @payment = Payment.new received_at: Time.zone.today
  end

  def create
    @payment = @gig.payments.create! params.require(:payment).permit(Payment.permitted_params)
    redirect_to(session.delete(:previous_url) || gigs_path)
  end

  private

  def load_and_authorize_gig!
    @gig = Gig.find params[:gig_id] # TODO: use policy_scope?
    authorize @gig, :update?
  end
end
