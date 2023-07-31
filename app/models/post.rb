class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  after_create :update_user_posts_counter
  after_create :update_comments_counter
  after_create :update_likes_counter

  validates :comments_counter, numericality: { only_integer: true, allow_nil: true },
                               comparison: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :likes_counter, numericality: { only_integer: true, allow_nil: true },
                            comparison: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :title, presence: true, allow_blank: false, length: { maximum: 250 }

  def update_user_posts_counter
    author.update_posts_counter
  end

  def update_comments_counter
    update(comments_counter: comments.count)
  end

  def update_likes_counter
    update(likes_counter: likes.count)
  end

  def last_comments
    comments.order(created_at: :desc).includes([:author]).limit(5)
  end
end
