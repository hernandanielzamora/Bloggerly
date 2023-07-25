require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validating Post Model' do
    before(:each) do
      @user = User.create(name: 'User', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'User Bio',
                          posts_counter: 0)
      @post = Post.new(author: @user, title: 'Title', text: 'First post', likes_counter: 0,
                       comments_counter: 0)
    end

    it 'Title must be present' do
      @post.title = 'Title'
      expect(@post).to be_valid
    end

    it 'Title must not be blank' do
      @post.title = nil
      expect(@post).to_not be_valid
    end

    it 'Title must be less than 250 characters' do
      @post.title = 'a' * 251
      expect(@post).to_not be_valid
    end

    it 'Recent comments must not be more than 5' do
      @post.save
      6.times do |n|
        @post.comments.create(text: "comment#{n}", author: @user)
      end
      expect(@post.last_comments.count).to eq(5)
    end

    it 'Comments counter must be an Integer >= 0' do
      @post.comments_counter = 'a'
      expect(@post).to_not be_valid

      @post.comments_counter = -1
      expect(@post).to_not be_valid

      @post.comments_counter = 0
      expect(@post).to be_valid
    end

    it 'Likes counter must be an Integer >= 0' do
      @post.likes_counter = 'a'
      expect(@post).to_not be_valid

      @post.likes_counter = -1
      expect(@post).to_not be_valid

      @post.likes_counter = 0
      expect(@post).to be_valid
    end
  end
end
