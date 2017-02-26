class GigsController < ApplicationController
  responders :collection
  respond_to :html

  before_action :authenticate_user!

  def index
    @gigs = Gig.all.order :start_time, :name
  end

  def new
    @gig = Gig.new
  end

  def create
    @gig = Gig.create! params.require(:gig).permit(Gig.permitted_params)
    respond_with @gig
  end
end
