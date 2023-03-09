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
              new_user_post_comment_path(user_id: current_user.id, post_id: post.id), class: 'link-new-comment'
    else
      link_to 'Leave a comment', new_user_post_comment_path(user_id: current_user.id, post_id: post.id),
              class: 'link-new-comment'
    end
  end

  def display_post(post, author: false)
    output = "<h2 class='post-title'>
      #{link_to(post.title, user_post_path(post.author_id, post.id))}"

    output += "<p>by #{link_to post.author.name, user_path(@post.author_id), class: 'post-author'}</p>" if author

    output += "<span class='post-id'>##{post.id}</span>
    </h2>
    <p class='post-body'>#{post.text}</p>
    <div class='post-info'>
      <p>Comments: #{post.comments_counter}, Likes: #{post.likes_counter}</p>
    </div>"

    if user_signed_in?
      output += "#{like_or_first_like_button(post)}
                 #{comment_or_first_comment_link(post)}<br>"
    end
    if can?(
      :destroy, post
    )
      output += button_to 'Delete post', user_post_path(post.author, post), method: :delete,
                                                                            data: { confirm: 'Are you sure?' }, class: 'btn-delete'
    end
    unless user_signed_in?
      output += "<p class='guest-no-comment-like'>You need to be #{link_to 'authenticated', new_user_session_path}
        in order to comment to or like this post</p>"
    end

    output.html_safe
  end

  def display_comment(post)
    if post.most_recent_comments.empty?
      '<p class="no-comments">No comments for this post yet. Be the first one to comment something!</p>'.html_safe
    else
      comments_html = ''
      post.most_recent_comments.each do |comment|
        comments_html += '<li>'
        comments_html += "<span class='.profile-photo'>
          <img src='#{comment.author.photo}' alt='' class='profile-photo'>
        </span>"
        comments_html += "<span class='author-name'>#{link_to comment.author.name, user_path(comment.author)}: </span>"
        comments_html += "<span class='comment-body'>#{comment.text}</span>"
        if can?(
          :destroy, comment
        )
          comments_html += button_to 'Delete comment', user_post_comment_path(comment.author, post, comment),
                                     method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn-delete'
        end
        comments_html += "<span class='comment-id'>##{comment.id}</span>"
        comments_html += '</li>'
      end
      "<ul>#{comments_html}</ul>".html_safe
    end
  end
end
