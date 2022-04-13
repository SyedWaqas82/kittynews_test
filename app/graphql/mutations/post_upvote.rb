module Mutations
    class PostUpvote < Mutations::BaseMutation

        argument :post_id, Integer, required: true

        field :post, Types::PostType, null: true
        field :errors, [String], null: false

        def resolve(post_id:)
            require_current_user!
            user = context[:current_user]
          
            this_post = Post.find_by(id: post_id)

            if this_post.present?
                 upvote = this_post.votes.create(user: user);
          
                if upvote.save
                    {
                        post: this_post,
                        errors: []
                    }
                else
                    upvote = this_post.votes.find_by(user_id: user.id)
                    upvote.destroy
                    {
                        post: this_post,
                        errors: []
                    }
                end
            else
                {
                    post: nil,
                    errors: ["record not found"]
                }
            end
        end
    end
end