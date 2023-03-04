require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before do
      get '/users'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders index template' do
      assert_template :index
    end

    it 'contains placeholder string inside the index view' do
      expect(response.body).to include 'In this page all the users will be displayed.'
    end
  end

  describe 'GET /show' do
    before do
      get '/users/4'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders show template' do
      assert_template :show
    end

    it 'contains placeholder string inside the show view' do
      expect(response.body).to match(/In this page the requested user .*? will be displayed./)
    end
  end
end
