class Day < ApplicationRecord
  belongs_to :period
  has_many :expenses
  validate :belongs_to_period_range

  private

  def belongs_to_period_range
    return if period.date_from <= day_date && day_date <= period.date_to

    errors.add(:day_date, :outside_range)
  end
end
