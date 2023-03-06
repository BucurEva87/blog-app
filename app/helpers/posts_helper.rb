module PostsHelper
  def like_or_first_like_button(post)
    if post.likes_counter.zero?
      button_to 'Be the first to like this post', user_post_likes_path(user_id: post.author.id, post_id: post.id),
                method: :post, class: 'btn-like'
    else
      button_to 'Like this post', user_post_likes_path(user_id: post.author.id, post_id: post.id), method: :post,
                                                                                                   class: 'btn-like'
    end
  end

  def comment_or_first_comment_link(post)
    if post.comments_counter.zero?
      link_to 'Be the first to leave a comment',
              new_user_post_comment_path(user_id: @current_user.id, post_id: post.id), class: 'link-new-comment'
    else
      link_to 'Leave a comment', new_user_post_comment_path(user_id: @current_user.id, post_id: post.id),
              class: 'link-new-comment'
    end
  end

  def display_post(post)
    "<h2 class='post-title'>
      #{link_to(post.title, user_post_path(post.author_id, post.id))}
      <span class='post-id'>##{post.id}</span>
    </h2>
    <p class='post-body'>#{post.text}</p>
    <div class='post-info'>
      <p>Comments: #{post.comments_counter}, Likes: #{post.likes_counter}</p>
    </div>
    #{like_or_first_like_button(post)}
    #{comment_or_first_comment_link(post)}".html_safe
  end

  def display_comment(post)
    if post.most_recent_comments.empty?
      '<p class="no-comments">No comments for this post yet. Be the first one to comment something!</p>'.html_safe
    else
      comments_html = ''
      post.most_recent_comments.each do |comment|
        comments_html += '<li>'
        comments_html += "<span class='author-name'>#{link_to comment.author.name, user_path(comment.author)}: </span>"
        comments_html += "<span class='comment-body'>#{comment.text}</span>"
        comments_html += "<span class='comment-id'>##{comment.id}</span>"
        comments_html += '</li>'
      end
      "<ul>#{comments_html}</ul>".html_safe
    end
  end
end
