class CreateUsrs < ActiveRecord::Migration[5.0]
  def change
    create_table :usrs do |t|
      t.string :username
      t.integer :role_id
      t.boolean :is_public

      t.timestamps
    end
  end
end
