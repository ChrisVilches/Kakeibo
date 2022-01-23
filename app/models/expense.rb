class Expense < ApplicationRecord
  include Discard::Model

  belongs_to :day
  auto_strip_attributes :label, squish: true
  before_validation :convert_nil_label_empty_string
  validates :cost, numericality: { greater_than_or_equal_to: 0 }, presence: true

  scope :discarded_before, ->(datetime) {
    where(arel_table[:discarded_at].lteq(datetime))
  }

  private

  def convert_nil_label_empty_string
    self.label ||= ''
  end
end
