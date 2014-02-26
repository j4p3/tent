object @post
    attributes :id, :headline, :content, :updated_at
    code :tags do |post|
        post.tag_ids
    end
    child :tags do
        attributes :id, :title
    end