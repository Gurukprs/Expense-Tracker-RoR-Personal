class IncomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_money_cycle

  def create
    @income = @money_cycle.incomes.new(income_params)

    if @income.save
      redirect_to money_cycle_path(@money_cycle), notice: "Income added!"
    else
      redirect_to money_cycle_path(@money_cycle), alert: "Failed to add income"
    end
  end

  private

  def set_money_cycle
    @money_cycle = current_user.money_cycles.find(params[:money_cycle_id])
  end

  def income_params
    params.require(:income).permit(:amount, :source, :date)
  end
end
