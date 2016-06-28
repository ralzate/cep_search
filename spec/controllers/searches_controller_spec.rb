require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  describe "POST #create" do
    let(:user) { User.create(provider: 'facebook', uid: '123123123') }
    it "should create a new search if given cep and user_id are valid" do
      allow(CEPSearchService).to receive(:search).and_return({status: 200, street: 'Test', city_state: 'Test - Test (TE)'})
      xhr :post, :create, search: { cep: '24220-031', user_id: user.id }
      expect(response).to render_template(:success)
      expect(Search.where(cep: '24220-031').any?).to be_truthy
    end

    it "should render error view when given attributes are invalid" do
      xhr :post, :create, search: { cep: '2422', user_id: user.id }
      expect(response).to render_template(:error)
      expect(Search.where(cep: '2422').any?).to be_falsey
    end
  end
end