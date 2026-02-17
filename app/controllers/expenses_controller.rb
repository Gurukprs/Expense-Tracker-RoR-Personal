class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_money_cycle

  def create
    @expense = @money_cycle.expenses.new(expense_params)

    if @expense.save
      @expenses = @money_cycle.expenses.order(date: :desc)
      respond_to do |format|
        format.html { redirect_to money_cycle_path(@money_cycle), notice: "Expense added!" }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to money_cycle_path(@money_cycle), alert: "Failed to add expense" }
        format.js
      end
    end
  end

  def destroy
    @expense = @money_cycle.expenses.find(params[:id])
    @expense.destroy
    # redirect_to money_cycle_path(@money_cycle), notice: "Expense deleted"
      @expenses = @money_cycle.expenses.order(date: :desc)

    respond_to do |format|
      format.html { redirect_to money_cycle_path(@money_cycle), notice: "Expense deleted" }
      format.js
    end

  end

  private

  def set_money_cycle
    @money_cycle = current_user.money_cycles.find(params[:money_cycle_id])
  end

  def expense_params
    params.require(:expense).permit(:amount, :category, :custom_category, :date, :description)
  end
end
