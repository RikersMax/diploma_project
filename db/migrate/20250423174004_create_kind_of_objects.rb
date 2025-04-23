class CreateKindOfObjects < ActiveRecord::Migration[7.1]
  def change
    create_table :kind_of_objects do |t|
      t.string :name_kind, limit: 64

      t.timestamps
    end
  end
end
