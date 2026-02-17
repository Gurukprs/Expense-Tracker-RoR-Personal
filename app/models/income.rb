class Income < ApplicationRecord
  belongs_to :money_cycle
  validates :amount, :source, :date, presence: true
end
