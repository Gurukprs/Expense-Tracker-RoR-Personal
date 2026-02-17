class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @money_cycles = current_user.money_cycles.order(created_at: :desc)

    @total_balance = @money_cycles.sum(&:balance)

    total_expense = @money_cycles.sum(&:total_expense)
    total_days = @money_cycles.sum(&:days_passed)

    @overall_avg = total_days > 0 ? (total_expense / total_days) : 0
  end
end
