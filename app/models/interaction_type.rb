class InteractionType < ActiveRecord::Base
  # Base values:
  # 'close'
  #     Close a post. Nonsensical until we have a reference for a post here :/
  # 
  # 'value'
  #     Assign voice to a user while closing a post
  # 
  # 'ping'
  #     Notify a user of availability in reference to a post
  # 
end
