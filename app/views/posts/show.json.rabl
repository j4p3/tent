object @post

node :post do |post|
    partial "posts/post/object", object: post
end

node :tags do |post|
    post.tags.map do |tag|
        partial "tags/tag/object", object: tag, root: false
    end
end