class Expense < ApplicationRecord
  belongs_to :money_cycle
  CATEGORIES = ["Breakfast", "Lunch", "Dinner", "Snacks", "Others"]
  validates :amount, :category, :date, presence: true

  def final_category
    category == "Others" && custom_category.present? ? custom_category : category
  end
end
