class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name_category, limit: 64
      t.references :accounting_object, null: false, foreign_key: true

      t.timestamps
    end
  end
end
