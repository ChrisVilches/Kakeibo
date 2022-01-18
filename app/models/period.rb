class Period < ApplicationRecord
  belongs_to :user
  has_many :days, -> { order(day_date: :asc) }
  validates :name, presence: true, allow_blank: false
  validate :dates_in_order
  validate :dates_are_different

  def amount_days
    (date_to - date_from + 1).to_i
  end

  private

  def dates_in_order
    return if date_from < date_to

    errors.add(:date_from, :dates_not_in_order)
  end

  def dates_are_different
    return if date_from != date_to

    errors.add(:date_from, :dates_are_equal)
  end
end
