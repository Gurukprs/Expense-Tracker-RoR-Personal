class MoneyCyclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_money_cycle, only: [:show, :edit, :update, :destroy, :close]

  def new
    @money_cycle = current_user.money_cycles.new
  end

  def create
    @money_cycle = current_user.money_cycles.new(money_cycle_params)
    @money_cycle.status = :active

    if @money_cycle.save
      # Automatically create first income (Home money)
      @money_cycle.incomes.create!(
        amount: params[:money_cycle][:initial_amount],
        source: "Home",
        date: @money_cycle.started_on
      )

      redirect_to root_path, notice: "Money cycle created successfully!"
    else
      render :new
    end
  end

  def show
  end

  def close
    @money_cycle.update(status: :closed)
    redirect_to root_path, notice: "Cycle closed successfully."
  end

  private

  def set_money_cycle
    @money_cycle = current_user.money_cycles.find(params[:id])
  end

  def money_cycle_params
    params.require(:money_cycle).permit(:title, :started_on)
  end
end