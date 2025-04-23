class CreateTypeObjects < ActiveRecord::Migration[7.1]
  def change
    create_table :type_objects do |t|
      t.string :name_type, limit: 64

      t.timestamps
    end
  end
end
