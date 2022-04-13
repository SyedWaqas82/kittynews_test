module Types
    class CommentType < Types::BaseObject
      field :id, Int, null: false
      field :text, String, null: false
      field :user, UserType, null: false

      def user
        RecordLoader.for(User).load(object.user_id)
      end
    end
  end
  