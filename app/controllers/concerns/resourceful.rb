module Resourceful
  extend ActiveSupport::Concern

  private

  def model_class
    @model_class ||= controller_name.classify.constantize
  end

  def model_name
    @model_name ||= controller_name.singularize
  end

  def model_params
    params.require(model_name).permit permitted_params
  end

  def permitted_params
    model_class.permitted_params
  end
end
