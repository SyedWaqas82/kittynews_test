import * as React from 'react';
import gql from 'graphql-tag';
import { useQuery } from 'react-apollo';
import renderComponent from './utils/renderComponent';
import Post from './Post';

const QUERY = gql`
  query PostsPage {
    viewer {
      id
    }
    postsAll {
      id
      title
      tagline
      url
      commentsCount
      votesCount
    }
  }
`;

function PostsIndex() {
  const { data, loading, error } = useQuery(QUERY);

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  return (
    <div className="box">
      {data.postsAll.map((post) => (
        <Post key={post.id} post={post}/>
      ))}
    </div>
  );
}

renderComponent(PostsIndex);
