class GigsController < ApplicationController
  include Resourceful

  responders :collection
  respond_to :html

  before_action :authenticate_user!
  skip_after_action :verify_authorized, only: [:new, :create]

  def index
    @gigs = policy_scope(Gig).order :start_time, :name
  end

  def new
    @gig = Gig.new
  end

  def create
    @gig = current_user.gigs.create! params.require(:gig).permit(Gig.permitted_params)
    respond_with @gig
  end

  def edit
    load_and_authorize_gig!
  end

  def update
    load_and_authorize_gig!
    @gig.update! params.require(:gig).permit(Gig.permitted_params)
    respond_with @gig
  end

  private

  def load_and_authorize_gig!
    @gig = Gig.find params[:id]
    authorize @gig
  end
end
