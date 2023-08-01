require 'rails_helper'

RSpec.describe 'Post Index', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) do
    User.create(name: 'Hernán Zamora', photo: 'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png',
                posts_counter: 5)
  end

  it "Shows the user's profile picture" do
    visit users_path(user_id: user.id)
    expect(page).to have_css("img[src='#{user.photo}']")
  end

  it "Shows the user's username" do
    visit users_path(user_id: user.id)
    expect(page).to have_content(user.name)
  end

  it 'Shows the number of posts written by the user' do
    visit users_path(user_id: user.id)
    expect(page).to have_content(user.posts_counter)
  end

  let!(:post) do
    Post.create(title: 'First Post', text: 'Testing text for first post', author: user, comments_counter: 0,
                likes_counter: 0)
  end

  it "Shows the post's title" do
    visit user_posts_path(user_id: user.id)
    expect(page).to have_content(post.title)
  end

  it "Shows the post's text" do
    visit user_posts_path(user_id: user.id)
    expect(page).to have_content(post.text)
  end

  let!(:comment) do
    Comment.create(text: 'Test comment', author: user, post:)
  end

  it 'Shows the first comments of the post' do
    visit user_posts_path(user_id: user.id)
    expect(page).to have_content(comment.text)
  end

  it 'Shows the number of comments' do
    visit user_posts_path(user_id: user.id)
    expect(page).to have_content(post.comments_counter)
  end

  it 'Shows the number of likes' do
    visit user_posts_path(user_id: user.id)
    expect(page).to have_content(post.likes_counter)
  end

  it 'When clicking on a post, the user is redirected to the posts/show page' do
    visit user_posts_path(user_id: user.id)
    click_link post.title
    expect(page).to have_current_path(user_post_path(user_id: user.id, id: post.id))
  end

  it 'Shows the pagination button' do
    Post.create(title: 'Second Post', text: 'Testing text for Second post', author: user, comments_counter: 0,
                likes_counter: 0)
    Post.create(title: 'Third Post', text: 'Testing text for Third post', author: user, comments_counter: 0,
                likes_counter: 0)
    visit user_posts_path(user_id: user.id)
    expect(page).to have_content('Pagination')
  end
end
