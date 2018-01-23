class Payment < ApplicationRecord
  belongs_to :gig, optional: false
  validates_presence_of :gig_id
end
