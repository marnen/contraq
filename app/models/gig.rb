class Gig < ActiveRecord::Base
  validates_presence_of :name, :start_time, :end_time
end
