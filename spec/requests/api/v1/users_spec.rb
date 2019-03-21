require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }

  before { host! "api.taskmanager.local" }

  describe "Get /users/:id" do
    before do
      headers = { "Accept" => "application/vnd.taskmanager.v1" }
      get "/users/#{user_id}", params: {}, headers: headers
    end

    context "when user exists" do
      it "returns the user" do
        user_response = JSON.parse(response.body)
        expect(user_response["id"]).to eq(user_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when user does not exist" do
      let(:user_id) { 10000 }

      it "return status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end
end
