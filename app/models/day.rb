class Day < ApplicationRecord
  belongs_to :period
  has_many :expenses, -> { kept }

  before_validation :format_memo
  validate :belongs_to_period_range, if: -> { day_date.present? }
  validates :day_date, presence: true

  scope :within, ->(from, to) {
    where([arel_table[:day_date].gteq(from), arel_table[:day_date].lteq(to)].inject(&:and))
  }

  private

  def format_memo
    self.memo = Util::MultilineTextFormatter.format memo
  end

  def belongs_to_period_range
    return if period.date_from <= day_date && day_date <= period.date_to

    errors.add(:day_date, :outside_range)
  end
end
