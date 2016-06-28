class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.references :post
      
      t.timestamps null: false
    end

    add_index :subscriptions, :user_id
    add_index :subscriptions, :post_id
  end
end
