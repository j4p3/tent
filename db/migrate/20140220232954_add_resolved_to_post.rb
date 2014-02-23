class AddResolvedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :resolved, :boolean, default: false
    add_column :posts, :resolved_at, :datetime
  end
end
