require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validating User Model' do
    before(:each) do
      @user = User.create(name: 'User', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'User Bio',
                          posts_counter: 0)
    end

    it 'Name must be present' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'Post counter must be an Integer >= 0' do
      @user.posts_counter = 'a'
      expect(@user).to_not be_valid

      @user.posts_counter = -1
      expect(@user).to_not be_valid

      @user.posts_counter = 0
      expect(@user).to be_valid
    end

    it 'Should return only 3 last posts' do
      last_posts = @user.last_posts.length
      expect(last_posts).to be < 3
    end

    it 'updates the posts_counter with the count of associated posts' do
      @user.posts.create(author: @user, title: 'Title', text: 'First post', likes_counter: 0,
                         comments_counter: 0)
      @user.update_posts_counter
      @user.reload
      expect(@user.posts_counter).to eq(1)
    end

    it 'updates the comments_counter with the count of associated comments' do
      post = @user.posts.create(author: @user, title: 'Title', text: 'First post', likes_counter: 0,
                                comments_counter: 0)
      post.comments.create(author_id: @user.id, text: 'Great post!')

      @user.update_comments_counter
      @user.reload
      expect(@user.comments_counter).to eq(1)
    end
  end
end
