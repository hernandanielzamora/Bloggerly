require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Validating Like Model' do
    before(:each) do
      @user = User.create(name: 'User', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'User Bio',
                          posts_counter: 0)
      @post = Post.create(author: @user, title: 'Title', text: 'First post', likes_counter: 0,
                          comments_counter: 0)
      @like = Like.new(author_id: @user.id, post_id: @post.id)
    end

    it 'Should update likes counter' do
      @like.save
      @post.reload
      expect(@post.likes_counter).to eq(1)
    end

    it 'author_id must be an Integer' do
      @like.author_id = 'a'
      expect(@like).to_not be_valid
    end

    it 'post_id must not be blank' do
      @like.post_id = nil
      expect(@like).to_not be_valid
    end
  end
end
