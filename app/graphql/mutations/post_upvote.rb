module Mutations
    class PostUpvote < Mutations::BaseMutation

        argument :post_id, Integer, required: true

        field :post, Types::PostType, null: false
        field :errors, [String], null: false
    
        #field :postId, Integer, null: false

        def resolve(post_id:)
            require_current_user!
            user = context[:current_user]
          
            this_post = Post.find(post_id)

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
                    errors: user.errors.full_messages
                }
            end
        end
    end
end