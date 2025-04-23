class CreateOperations < ActiveRecord::Migration[7.1]
  def change
    create_table :operations do |t|
      t.references :accounting_object, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.datetime :data_stamp
      t.decimal :amount_of_money, precision: 10, scale: 2
      t.text :description, limit: 1000

      t.timestamps
    end
  end
end
