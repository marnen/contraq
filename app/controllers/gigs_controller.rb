class GigsController < ApplicationController
  responders :collection
  respond_to :html

  before_action :authenticate_user!

  def index
    @gigs = current_user.gigs.order :start_time, :name
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
