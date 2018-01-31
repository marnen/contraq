class GigsController < ApplicationController
  include Resourceful

  responders :collection
  respond_to :html

  before_action :load_and_authorize_resource!, only: [:show, :edit, :update]
  skip_after_action :verify_authorized, only: [:new, :create]

  def index
    @page_title = _ 'Gigs'
    @gigs = policy_scope(Gig).order(:start_time, :name).decorate
  end

  def show
    @page_resource = @gig
    @page_title = @gig.name
    @header_class = :name
    @gig = @gig.decorate
  end

  def new
    @page_title = _ 'Create Gig'
    @gig = Gig.new
  end

  def create
    @gig = current_user.gigs.create! model_params
    respond_with @gig
  end

  def edit
    @page_title = (_ 'Edit Gig "%{gig}"') % {gig: @gig.name}
  end

  def update
    @gig.update! model_params
    respond_with @gig
  end
end
