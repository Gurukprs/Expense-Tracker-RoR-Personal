class MoneyCycle < ApplicationRecord
  belongs_to :user
  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy

  enum status: { active: 0, closed: 1 }

  validates :title, :started_on, presence: true
  validate :only_one_active_cycle

  def total_income
    incomes.sum(:amount)
  end

  def total_expense
    expenses.sum(:amount)
  end

  def balance
    total_income - total_expense
  end

  def days_passed
    (Date.current - started_on).to_i + 1
  end

  def average_per_day
    return 0 if days_passed <= 0
    total_expense / days_passed
  end

  def burn_rate_status
    return "No Data" if average_per_day == 0

    remaining_days = balance / average_per_day

    if remaining_days >= 7
      "safe"
    elsif remaining_days >= 3
      "moderate"
    else
      "danger"
    end
  end

  private

  def only_one_active_cycle
    if active? && user.money_cycles.where(status: :active).where.not(id: id).exists?
      errors.add(:status, "Only one active cycle allowed")
    end
  end
end
