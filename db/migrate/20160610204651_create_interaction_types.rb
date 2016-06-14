class CreateInteractionTypes < ActiveRecord::Migration
  def change
    create_table :interaction_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
