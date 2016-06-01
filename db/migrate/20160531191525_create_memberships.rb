class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user
      t.references :tent

      t.timestamps null: false
    end

    add_index :memberships, :user_id
    add_index :memberships, :tent_id
  end
end
