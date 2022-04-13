import * as React from 'react';
import gql from 'graphql-tag';
import { useQuery } from 'react-apollo';
import renderComponent from './utils/renderComponent';
import Post from './Post';
import Comment from './Comment';

const QUERY = gql`
  query GetPost($postId: Int!) {
    getPost(postId: $postId)
    {
      id
      title
      tagline
      url
      commentsCount
      votesCount
      user
      {
        id
        name
      }
      comments
      {
        id,
        text
        user
        {
          id
          name
        }
      }
    }
  }
`;

function PostsShow({ postId }) {

  const { data, loading, error } = useQuery(QUERY,{variables: {postId: postId}});

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  const post = data.getPost;

  return (
    <>
      <div className="box">
        <Post key={post.id} post={post}/>
      </div>
      <div className="box">
        <h3>{post.commentsCount} Comments</h3>
        {
          post.comments.map(comment => <Comment key={comment.id} comment={comment}/>)
        }
      </div>
    </>
  );
}

renderComponent(PostsShow);
