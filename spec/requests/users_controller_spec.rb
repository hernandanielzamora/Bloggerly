require 'rails_helper'

RSpec.describe '/users', type: :request do
  let(:user) do
    User.create(
      name: 'Hernán Zamora',
      photo: 'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png',
      bio: 'Software Engineer',
      posts_counter: 0
    )
  end

  let(:user2) do
    User.create(
      name: 'Martin Escobar',
      photo: 'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png',
      bio: 'Actor',
      posts_counter: 0
    )
  end

  before do
    user
    user2
  end

  describe 'GET /index' do
    it 'Shows all the users' do
      get '/'
      expect(response).to render_template 'users/index'
      expect(response.body).to include('Hernán Zamora')
      expect(response.body).to include('Martin Escobar')
    end
  end

  describe 'GET /show' do
    it 'Shows details for a given user' do
      get "/users/#{user.id}"
      expect(response).to render_template 'users/show'
      expect(response.body).to include('Hernán Zamora')
      expect(response.body).to include('Software Engineer')
    end
  end
end
