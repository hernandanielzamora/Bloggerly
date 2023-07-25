require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'Get /index' do
    before :example do
      get '/users/1/posts'
    end
    it 'returns http success (code 200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the posts index template' do
      expect(response).to render_template(:index)
    end

    it 'renders the correct content' do
      expect(response.body).to include('Posts for a given user')
    end
  end

  describe 'Get /show' do
    before :example do
      get '/users/1/posts/2'
    end
    it 'returns http success (code 200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the posts show template' do
      expect(response).to render_template(:show)
    end

    it 'renders the correct content' do
      expect(response.body).to include('Details of the post')
    end
  end
end
