class Day < ApplicationRecord
  belongs_to :period
  has_many :expenses
  validate :belongs_to_period_range
  validates :day_date, presence: true

  private

  def belongs_to_period_range
    return if day_date.nil?
    return if period.date_from <= day_date && day_date <= period.date_to

    errors.add(:day_date, :outside_range)
  end
end
