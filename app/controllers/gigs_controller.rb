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
    @gig = Gig.find params[:id]
  end

  def update
    @gig = Gig.find params[:id]
    @gig.update! params.require(:gig).permit(Gig.permitted_params)
    respond_with @gig
  end
end
