module Mutations
    class AddComment < Mutations::BaseMutation

        argument :post_id, Integer, required: true
        argument :commentText, String, required: true

        field :comment, Types::CommentType, null: true
        field :errors, [String], null: false

        def resolve(post_id:, commentText:)
            require_current_user!
            user = context[:current_user]
          
            this_post = Post.find_by(id: post_id)

            if this_post.present?
                 comment = this_post.comments.new(user: user, text: commentText)
          
                if comment.save
                    {
                        comment: comment,
                        errors: []
                    }
                else
                    {
                        comment: nil,
                        errors: comment.errors.full_messages
                    }
                end
            else
                {
                    comment: nil,
                    errors: ["record not found"]
                }
            end
        end
    end
end