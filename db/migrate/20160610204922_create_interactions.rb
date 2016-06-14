class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.references :interaction_type, index: true, foreign_key: true
      t.references :origin_user, references: :user, null: false
      t.references :target_user, references: :user
      t.references :tent, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :interactions, :origin_user_id
    add_index :interactions, :target_user_id
  end
end
