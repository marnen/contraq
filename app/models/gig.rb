class Gig < ApplicationRecord
  belongs_to :user
  has_many :payments
  validates_presence_of :name, :start_time, :end_time, :user_id

  def self.permitted_params
    @permitted_params ||= column_names - [:created_at, :updated_at]
  end

  def due_date
    terms.present? ? start_time.advance(days: terms) : nil
  end

  def overdue?
    due_date.present? ? due_date < Date.today.beginning_of_day : nil
  end
end
