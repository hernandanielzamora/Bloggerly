require 'rails_helper'

RSpec.describe 'User Index', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:first_user) { User.create(name: 'Hernán', photo: 'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png', posts_counter: 3) }
  let!(:second_user) { User.create(name: 'Jhon', photo: 'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png', posts_counter: 5) }
  let!(:third_user) { User.create(name: 'Martin', photo: 'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png', posts_counter: 2) }

  it 'Shows every user' do
    visit users_path

    expect(page).to have_content(first_user.name)
    expect(page).to have_content(second_user.name)
    expect(page).to have_content(third_user.name)
  end

  it 'Shows every profile photo' do
    visit users_path

    expect(page).to have_css("img[src='#{first_user.photo}']")
    expect(page).to have_css("img[src='#{second_user.photo}']")
    expect(page).to have_css("img[src='#{third_user.photo}']")
  end

  it 'Shows the post counter for every user' do
    visit users_path

    expect(page).to have_content("Number of posts: #{first_user.posts_counter}")
    expect(page).to have_content("Number of posts: #{second_user.posts_counter}")
    expect(page).to have_content("Number of posts: #{third_user.posts_counter}")
  end

  it "Redirects to the correct user's page" do
    visit users_path

    click_link first_user.name
    expect(page).to have_current_path(user_path(first_user))
  end
end
