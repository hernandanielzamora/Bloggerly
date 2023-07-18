class User < ApplicationRecord
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :posts, foreign_key: :author_id

  def update_posts_counter
    update(posts_counter: posts.count)
  end

  def update_comments_counter
    update(comments_counter: comments.count)
  end

  def last_posts
    posts.order(created_at: :desc).limit(3)
  end
end
