require 'rails_helper'

RSpec.describe 'User Show Page', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) do
    User.create(name: 'Hernán Zamora', photo: 'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png',
                posts_counter: 0)
  end

  let(:post) do
    Post.create(title: 'First Post', text: 'Testing text for first post', author: user, comments_counter: 0,
                likes_counter: 0)
  end

  before do
    user
    post
    visit user_path(user)
  end

  context 'User profile section' do
    it 'shows the user profile picture' do
      photo = find('.user-img')

      expect(photo).to be_visible
      expect(photo['src']).to eq user.photo
    end

    it "Shows the user's username" do
      expect(page).to have_content(user.name)
    end

    it 'Shows the number of posts for the user' do
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end

    it "Shows the user's bio" do
      expect(page).to have_content(user.bio)
    end
  end

  context 'User Show view' do
    it "Shows the user's first three posts" do
      expect(page).to have_content(post.title)
    end

    it 'Shows a button that redirects to posts index' do
      expect(page).to have_link('See all posts')
    end

    it 'Redirects the user to the all posts page' do
      click_link 'See all posts'

      expect(page).to have_current_path(user_posts_path(user))
    end
  end
end
