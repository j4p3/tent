class Event
  include ActiveModel::Serialization
  attr_reader :id, :updated_at, :type, :post, :user, :type_content

  # 
  # Used for serializing Post, Message, Interaction events uniformly
  # Looks like:
  # 
  # {
  #   ##### base information
  #   id: 
  #   updated_at: 
  #   type: :string
  #   post: {
  #     <post>
  #   }
  #   user: {
  #     <user *responsible* for event - responder, interacter, sender>
  #   }
  # 
  #   ##### type-specific
  #   interaction_type: :string
  #   last_message: {
  #     <message>
  #   }
  #   tent: {
  #     <tent>
  #   }
  # }
  # 

  @@normalize = {
    Post => Proc.new { |e|
      {
        id: e.id,
        updated_at: e.last_message ? Time.at(e.last_message[:created_at]).to_datetime : e.updated_at,
        type: e.last_message ? :message : :post,
        post: e,
        user: e.last_message ? e.last_message[:user] : e.user,
        type_content: e.last_message == nil ? nil : {
          last_message: e.last_message[:text]
        }
      }
    },
    Interaction => Proc.new { |e|
      {
        id: e.id,
        updated_at: e.updated_at,
        type: :interaction,
        post: e.post,
        user: e.user,
        type_content: {
          interaction_type: e.interaction_type.name
        }
      }
    }
  }

  def initialize(event={})
    # Absolutely filthy way to turn variable params into a consistent object
    @@normalize[event.class].call(event).each do |k, v|
      instance_variable_set("@#{k}", v)
    end
  end
end
