class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id

  def most_recent_comments
    Comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_posts_counter
    author.increment!(:posts_counter)
  end
end
