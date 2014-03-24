class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      # t.string :encrypted_password, null: false, default: "" No password (yet).

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Omniauthable
      t.string :provider
      t.string :uid
      t.string :facebook_token

      ## Token authenticable
      t.string :authentication_token

      # Extra Attributes
      t.string :name
      t.string :avatar
      t.timestamps
    end

    add_index :users, :email,                unique: true
    # add_index :users, :reset_password_token, unique: true
    add_index :users, :authentication_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
