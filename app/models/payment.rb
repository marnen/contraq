class Payment < ApplicationRecord
  belongs_to :gig, optional: false
  validates_presence_of :gig_id

  def self.permitted_params
    @permitted_params ||= column_names - [:created_at, :updated_at, :gig_id]
  end
end
