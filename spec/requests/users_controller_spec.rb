require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before :example do
      get '/users'
    end
    it 'returns http success (code 200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the users index template' do
      expect(response).to render_template(:index)
    end

    it 'renders the correct content' do
      expect(response.body).to include('List of users')
    end
  end

  describe 'GET /show' do
    before :example do
      get '/users/1'
    end

    it 'returns http success (code 200)' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the users show template' do
      expect(response).to render_template(:show)
    end

    it 'renders the correct content' do
      expect(response.body).to include('User Details: ')
    end
  end
end
