require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Validating Comment Model' do
    before(:each) do
      @user = User.create(name: 'User', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'User Bio',
                          posts_counter: 0)
      @post = Post.create(author: @user, title: 'Title', text: 'First post', likes_counter: 0,
                          comments_counter: 0)
      @comment = Comment.new(text: 'comment1', author_id: 1, post_id: 2)
    end

    it 'Text must be present' do
      @comment.text = nil
      expect(@comment).to_not be_valid
    end

    it 'author_id must be an Integer' do
      @comment.author_id = 'a'
      expect(@comment).to_not be_valid
    end

    it 'post_id must be an Integer' do
      @comment.post_id = 'a'
      expect(@comment).to_not be_valid
    end

    it 'Should update comments counter' do
      comment = Comment.new(author: @user, post: @post)
      comment.save
      expect(@post.comments_counter).to eq(1)
    end
  end
end
