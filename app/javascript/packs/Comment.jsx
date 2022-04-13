import React from 'react'

function Comment({comment}) {
  return (
    <article className="post">
        <strong>{comment.user.name}</strong>
        <p>{comment.text}</p>
    </article>
  )
}

export default Comment