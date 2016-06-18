class AddPostToInteraction < ActiveRecord::Migration
  def change
    add_reference :interactions, :post, index: true
  end
end
