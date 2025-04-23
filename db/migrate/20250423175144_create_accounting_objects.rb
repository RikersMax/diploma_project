class CreateAccountingObjects < ActiveRecord::Migration[7.1]
  def change
    create_table :accounting_objects do |t|
      t.string :name_object, limit: 64
      t.references :user, null: false, foreign_key: true
      t.references :type_object, null: false, foreign_key: true
      t.references :kind_of_object, null: false, foreign_key: true

      t.timestamps
    end
  end
end
