class MakeTagsUnique < ActiveRecord::Migration
  def change
    add_index :tags, [:title], unique: true
  end
end
