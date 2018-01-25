module Resourceful
  extend ActiveSupport::Concern
  include Authorization

  private

  def load_and_authorize_resource!
    self.model = model_class.find(params[:id])
    authorize model
  end

  def model
    instance_variable_get model_var
  end

  def model=(value)
    instance_variable_set model_var, value
  end

  def model_class
    @model_class ||= controller_name.classify.constantize
  end

  def model_name
    @model_name ||= controller_name.singularize
  end

  def model_params
    params.require(model_name).permit permitted_params
  end

  def model_var
    @model_var ||= :"@#{model_name}"
  end

  def permitted_params
    model_class.permitted_params
  end
end
