class Period < ApplicationRecord
  MAX_DAYS = 100
  MIN_DAYS = 7

  belongs_to :user
  has_many :days, ->(period) { within(period.date_from, period.date_to).order(day_date: :asc) }

  auto_strip_attributes :name, squish: true
  validates :name, presence: true, allow_blank: false
  validates :date_to, presence: true
  validates :date_from, presence: true

  with_options if: -> { date_to.present? && date_from.present? } do
    validate :dates_in_order
    validate :dates_are_different
    validate :period_length_correct
  end

  def amount_days
    (date_to - date_from + 1).to_i
  end

  def full_days
    i = 0

    (date_from..date_to).map do |date|
      if i < days.count && days[i].day_date == date
        day = days[i]
        i += 1
        day
      else
        Day.new(day_date: date)
      end
    end
  end

  private

  def period_length_correct
    errors.add(:amount_days, :period_is_too_long, max_days: MAX_DAYS) if amount_days > MAX_DAYS
    errors.add(:amount_days, :period_is_too_short, min_days: MIN_DAYS) if amount_days < MIN_DAYS
  end

  def dates_in_order
    return if date_from < date_to

    errors.add(:date_from, :dates_not_in_order)
  end

  def dates_are_different
    return if date_from != date_to

    errors.add(:date_from, :dates_are_equal)
  end
end
