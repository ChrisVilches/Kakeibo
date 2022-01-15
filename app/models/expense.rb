class Expense < ApplicationRecord
  belongs_to :day
  validates :cost, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
