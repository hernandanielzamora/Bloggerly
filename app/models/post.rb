class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  after_create :update_posts_count

  def update_posts_count
    author.update_posts_counter
  end

  def update_comments_counter
    update(comments_counter: comments.count)
  end

  def update_likes_counter
    update(likes_counter: likes.count)
  end

  def last_comments
    comments.order(created_at: :desc).limit(5)
  end
end
