class AddLinkToUser < ActiveRecord::Migration
  def change
    add_column :users, :link, :string
  end
end
