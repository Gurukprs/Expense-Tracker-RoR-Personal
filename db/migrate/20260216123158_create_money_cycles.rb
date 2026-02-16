class CreateMoneyCycles < ActiveRecord::Migration[6.1]
  def change
    create_table :money_cycles do |t|
      t.string :title
      t.date :started_on
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
