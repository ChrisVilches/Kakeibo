class Day < ApplicationRecord
  belongs_to :period
  validate :belongs_to_period_range

  private

  def belongs_to_period_range
    # TODO: Inside dates (inclusive)
    # period.date_from
    # period.date_to
  end
end
