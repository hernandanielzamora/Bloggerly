class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :likes, foreign_key: :author_id
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy

  validates :name, presence: true, allow_blank: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }

  before_create :set_initial_posts_counter
  before_save :generate_api_token

  def update_posts_counter
    update_column(:posts_counter, posts.count)
  end

  def update_comments_counter
    update_column(:comments_counter, comments.count)
  end

  def last_posts
    posts.order(created_at: :desc).limit(3)
  end

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= 'user'
  end

  private

  def generate_api_token
    self.api_token = SecureRandom.hex(16)
  end

  def set_initial_posts_counter
    self.posts_counter = 0
  end
end
