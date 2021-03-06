# == Schema Information
#
# Table name: tents
#
#  id         :integer          not null, primary key
#  name       :string
#  desc       :string
#  user_id    :integer
#  image      :string
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tent < ActiveRecord::Base
  # Relations
  belongs_to :owner, class_name: 'User'
  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts
  belongs_to :parent, class_name: 'Tent', foreign_key: 'parent_id'
  has_many :children, class_name: 'Tent', foreign_key: 'parent_id'

  def and_descendant_posts
    # @todo implement
    [self]
  end

  def descendant_posts
    and_descendants.map(&:posts).flatten
  end

  def and_parents
    [self] + parents
  end

  def parents (a=[])
    if self.parent
      a += [self.parent]
      a += [self.parent.parents(a)]
    else
      a
    end
  end

  def and_descendants
    [self] + descendants
  end

  def descendants
    children.map do |child|
      [child] + child.descendants
    end.flatten
  end

  def and_descendants_tree
    hash = self.serializable_hash
    hash[:children] = self.descendants_tree
    hash
  end

  def descendants_tree
    children.map do |child|
      foos = child.descendants_tree
      hash = child.serializable_hash
      hash[:children] = foos
      hash
    end
  end

  def descendants_tree_for(user)
    children.map do |child|
      if (user.memberships.includes(child))
        foos = child.descendants_tree
        hash = child.serializable_hash
        hash[:children] = foos
        hash
      end
    end
  end

  def and_descendants_tree_for(user)
    hash = self.serializable_hash
    hash[:children] = self.descendants_tree
    hash
  end

  private

  def self.tree_for(i)
    where("#{table_name}.id IN (#{tree_sql_for(instance)})").order("#{table_name}.id")
  end

  def self.tree_sql_for(i)
    tree_sql =  <<-SQL
      WITH RECURSIVE search_tree(id, path) AS (
          SELECT id, ARRAY[id]
          FROM #{table_name}
          WHERE id = #{instance.id}
        UNION ALL
          SELECT #{table_name}.id, path || #{table_name}.id
          FROM search_tree
          JOIN #{table_name} ON #{table_name}.parent_id = search_tree.id
          WHERE NOT #{table_name}.id = ANY(path)
      )
      SELECT id FROM search_tree ORDER BY path
    SQL
  end
end
