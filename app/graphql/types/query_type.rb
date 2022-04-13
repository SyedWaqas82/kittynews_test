module Types
  class QueryType < Types::BaseObject
    field :posts_all, [PostType], null: false

    def posts_all
      Post.reverse_chronological.all
    end

    field :viewer, ViewerType, null: true

    def viewer
      context.current_user
    end

    field :get_post, PostType, null: false do
      argument :post_id, Int, required: true
    end
    
    def get_post(post_id:)
      Post.find_by(id: post_id)
    end
  end
end
