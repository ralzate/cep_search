require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:cep) }
    it { is_expected.to validate_length_of(:cep) }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:user) }
  end
end
