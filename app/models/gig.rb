class Gig < ActiveRecord::Base
  validates_presence_of :name, :start_time, :end_time

  def self.permitted_params
    @permitted_params ||= column_names - [:created_at, :updated_at]
  end
end
