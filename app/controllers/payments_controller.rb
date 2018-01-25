class PaymentsController < ApplicationController
  include Authorization

  respond_to :html

  before_action :load_and_authorize_gig!, only: %i[new create]
  before_action :load_and_authorize_payment!, only: %i[edit update]
  before_action :save_previous_url, only: %i[new edit]

  def new
    @payment = Payment.new received_at: Time.zone.today
  end

  def create
    @payment = @gig.payments.create! params.require(:payment).permit(Payment.permitted_params)
    respond_with @payment, location: previous_url
  end

  def edit
  end

  def update
    @payment.update! params.require(:payment).permit(Payment.permitted_params)
    respond_with @payment, location: previous_url
  end

  private

  def load_and_authorize_gig!
    @gig = Gig.find params[:gig_id] # TODO: use policy_scope?
    authorize @gig, :update?
  end

  def load_and_authorize_payment!
    @payment = Payment.find params[:id]
    authorize @payment
  end

  def save_previous_url
    session[:previous_url] = request.headers['referer']
  end

  def previous_url
    session.delete(:previous_url) || gigs_path
  end
end
