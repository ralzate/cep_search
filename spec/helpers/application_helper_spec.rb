require 'spec_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#current_user' do
    it 'should return nil if session is blank' do
      session[:user_id] = nil
      expect(helper.current_user).to be_nil
    end

    it 'should return given user if session is not blank' do
      user = User.create(name: 'Test User', provider: 'facebook', uid: '123123123', email: 'test@email.com')
      session[:user_id] = user.id
      expect(helper.current_user).to eq(user)
    end
  end
end