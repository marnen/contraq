class GigsController < ApplicationController
  include Resourceful

  responders :collection
  respond_to :html

  before_action :load_and_authorize_resource!, only: [:show, :edit, :update]
  skip_after_action :verify_authorized, only: [:new, :create]

  def index
    @gigs = policy_scope(Gig).order(:start_time, :name).decorate
  end

  def show
    @gig = @gig.decorate
  end

  def new
    @gig = Gig.new
  end

  def create
    @gig = current_user.gigs.create! model_params
    respond_with @gig
  end

  def edit
  end

  def update
    @gig.update! model_params
    respond_with @gig
  end
end
