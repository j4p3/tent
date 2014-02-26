collection @posts => :posts
    attributes :id, :headline, :content, :updated_at
    code :tags do |post|
        post.tag_ids
    end