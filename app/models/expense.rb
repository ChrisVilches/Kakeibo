class Expense < ApplicationRecord
  include Discard::Model

  belongs_to :day
  auto_strip_attributes :label, squish: true
  validates :cost, numericality: { greater_than_or_equal_to: 0 }, presence: true

  scope :discarded_before, ->(datetime) {
    where(arel_table[:discarded_at].lteq(datetime))
  }
end
