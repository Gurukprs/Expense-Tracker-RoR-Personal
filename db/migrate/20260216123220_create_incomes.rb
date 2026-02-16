class CreateIncomes < ActiveRecord::Migration[6.1]
  def change
    create_table :incomes do |t|
      t.decimal :amount
      t.string :source
      t.date :date
      t.references :money_cycle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
