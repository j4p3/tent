class CreateTents < ActiveRecord::Migration
  def change
    create_table :tents do |t|
      t.string :name
      t.string :desc
      t.references :user, index: true, foreign_key: true
      t.string :image
      t.references :parent, references: :tents

      t.timestamps null: false
    end
  end
end
