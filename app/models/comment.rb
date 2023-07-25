class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_create :update_post_comments_counter
  after_create :update_user_comments_counter

  def update_post_comments_counter
    post.update_comments_counter
  end

  def update_user_comments_counter
    author.update_comments_counter
  end
end
