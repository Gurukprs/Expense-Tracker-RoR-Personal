class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.string :category
      t.string :custom_category
      t.date :date
      t.text :description
      t.references :money_cycle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
