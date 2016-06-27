require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:uid) }
  end

  describe ".create_or_update_by_oauth" do
    it "should return a user with given attributes" do
      auth = {
          'provider' => 'facebook',
          'uid' => '123123123',
          'info' => {
              'name' => 'Test User',
              'email' => 'test_user@email.com',
              'image' => 'test_user_pic.jpg'
          }
      }
      user = User.create_or_update_by_oauth(auth)
      expect(user.provider).to eq(auth['provider'])
      expect(user.uid).to eq(auth['uid'])
      expect(user.name).to eq(auth['info']['name'])
      expect(user.email).to eq(auth['info']['email'])
      expect(user.image).to eq(auth['info']['image'])
    end
  end
end
