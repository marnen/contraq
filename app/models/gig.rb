class Gig < ApplicationRecord
  belongs_to :user
  has_many :payments, class_name: '::Payment' # TODO: needed because of Gig::Payment in cells; can we rename that module or the Payment class?
  validates_presence_of :name, :start_time, :end_time, :user_id

  def self.permitted_params
    @permitted_params ||= column_names - [:created_at, :updated_at]
  end
end
