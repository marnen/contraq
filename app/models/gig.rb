class Gig < ApplicationRecord
  belongs_to :user
  has_many :payments
  validates_presence_of :name, :start_time, :end_time, :user_id

  def self.permitted_params
    @permitted_params ||= column_names - [:created_at, :updated_at]
  end
end
