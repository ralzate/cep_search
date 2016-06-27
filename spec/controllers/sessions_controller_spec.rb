require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'should redirect to facebook auth path' do
      get :new
      expect(response).to redirect_to('/auth/facebook')
    end
  end

  describe 'GET #create' do
    it 'should not set current user if given auth is blank' do
      request.env["omniauth.auth"] = nil
      get :create, provider: ''
      expect(response).to redirect_to(root_path)
      expect(session[:user_id]).to be_nil
    end

    it 'should create or update the user with given auth if auth is not blank' do
      request.env["omniauth.auth"] = {
          'provider' => 'facebook',
          'uid' => '123123123',
          'info' => {
              'name' => 'Test User',
              'email' => 'test_user@email.com',
              'image' => 'test_user_pic.jpg'
          }
      }
      get :create, provider: 'facebook'
      expect(response).to redirect_to(root_path)
      expect(session[:user_id]).not_to be_nil
    end
  end

  describe 'DELETE #destroy' do
    it 'should reset the session and redirect to root_path' do
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end
end
