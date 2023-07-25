class User < ApplicationRecord
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :posts, foreign_key: :author_id

  validates :name, presence: true

  before_create :set_initial_posts_counter

  def update_posts_counter
    update_column(:posts_counter, posts.count)
  end

  def update_comments_counter
    update_column(:comments_counter, comments.count)
  end

  def last_posts
    posts.order(created_at: :desc).limit(3)
  end

  private

  def set_initial_posts_counter
    self.posts_counter = 0
  end
end
