class AddPostsToTents < ActiveRecord::Migration
  def change
    add_reference :posts, :tent, index: true
  end

  add_index :tents, :parent_id
end
