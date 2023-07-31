require 'rails_helper'

RSpec.describe 'Post Show', type: :system do
  before do
    driven_by(:rack_test)
  end

  user = User.create(name: 'Jhon Doe', photo: 'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png',
                     posts_counter: 5)

  post = Post.create(title: 'My First Post', text: 'Text for my first post', author: user, comments_counter: 0,
                     likes_counter: 0)

  comment = Comment.create(text: 'Comment for my first post', author: user, post:)

  it "Shows post's title" do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(post.title)
  end

  it "Shows post's writter" do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(user.name)
  end

  it 'Shows the comments counter for the post' do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(post.comments_counter)
  end

  it 'Shows the ammount of likes for the post' do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(post.likes_counter)
  end

  it 'Shows the post text' do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(post.text)
  end

  it "Shows the user's username" do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(comment.author.name)
  end

  it 'Shows the comments' do
    visit user_post_path(user_id: user.id, id: post.id)
    expect(page).to have_content(comment.text)
  end
end
