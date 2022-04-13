import React from 'react'
import gql from 'graphql-tag';
import { useMutation } from 'react-apollo';

const UP_VOTE = gql`
  mutation postUpvote($postId: Int!)
  {
    postUpvote(postId: $postId)
    {
      post
      {
        id
        votesCount
      }
      errors
    }
  }
`;

function Post({post}) {
    const [upVote, { data, loading, error }] = useMutation(UP_VOTE);

    if (loading) return 'Voting...';
    if (error) 
    {
        if(error.message === "GraphQL error: current user is missing")
        {
            location.href = "/users/sign_in";
        }

        return `Voting error! ${error.message}`;
    }

    function voteHandler(e)
    {
        e.preventDefault();
        upVote({ variables: { postId: post.id } });
    }

    return (
        <React.Fragment>
            <article className="post">
            <h2>
                <a href={`/posts/${post.id}`}>{post.title}</a>
            </h2>
            <div className="url">
                <a href={post.url}>{post.url}</a>
            </div>
            <div className="tagline">{post.tagline}</div>
            <footer>
                <button onClick={(e) => voteHandler(e)}>🔼 {post.votesCount} </button>
                {/* <button>💬 {post.commentsCount}</button> */}
                {post.commentsCount} comments | author:{' '} {post.user.name}
            </footer>
            </article>
        </React.Fragment>
    )
}

export default Post