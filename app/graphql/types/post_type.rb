module Types
  class PostType < Types::BaseObject
    field :id, Int, null: false
    field :title, String, null: false
    field :tagline, String, null: false
    field :url, String, null: false
    field :user, UserType, null: false
    field :comments_count, Int, null: false
    field :votes_count, Int, null: false
    field :comments, [CommentType], null: true

    def user
      RecordLoader.for(User).load(object.user_id)
    end

    def comments
      AssociationLoader.for(object.class, :comments).load(object)
    end
  end
end
