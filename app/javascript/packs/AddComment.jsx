import React, { useState } from 'react'
import gql from 'graphql-tag';
import { useMutation } from 'react-apollo';

const ADD_COMMENT = gql`
  mutation addComment($postId: Int!, $commentText: String!)
  {
    addComment(postId: $postId, commentText : $commentText)
    {
        comment
        {
          id,
          text
          user
          {
            id
            name
          }
        },
        errors
    }
  }
`;

function AddComment ({postId,onCreateComment}) {

    const [commentText, setCommentText] = useState('');

    const [addComment, { data, loading, error }] = useMutation(ADD_COMMENT,{
    update(cache, { data: { addComment } }) {
        onCreateComment(cache,addComment);
        setCommentText('');
    }
   });

    if (loading) return 'Commenting...';
    if (error) 
    {
        if(error.message === "GraphQL error: current user is missing")
        {
            location.href = "/users/sign_in";
        }

        return `Comment error! ${error.message}`;
    }

    function addCommnetHandler(e) {
        e.preventDefault();
        addComment({ variables: { postId: postId, commentText: commentText } });
    }

    return (
      <div>
          <form onSubmit={e => addCommnetHandler(e)}>
              <textarea style={{width: '100%', height:'200px'}} required name="commentText" value={commentText} onChange={(e) => setCommentText(e.target.value)}/><br/>
              <button type='submit'>Add Comment</button>
          </form>
      </div>
    )
  
}

export default AddComment