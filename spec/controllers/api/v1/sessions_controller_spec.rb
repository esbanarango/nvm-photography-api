require 'rails_helper'

describe API::V1::SessionsController do

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  let(:user) {create(:user)}

  context "with valid credentials" do

    describe "POST#create" do
      it "returns the user's authentication token" do

        valid_credentials = {
          user: {
            email: user.email,
            password: user.password
          }
        }

        post :create, valid_credentials
        expect(response.status).to eq(200)
        expect(json['token']).to eq(user.sessions.last.authentication_token)
      end
    end

  end

  context "with invalid credentials" do

    describe "POST#create" do
      it "returns the errors messages" do

        invalid_credentials = {
          user: {
            email: user.email,
            password: '123'
          }
        }

        post :create, invalid_credentials
        expect(response.status).to eq(401)
        expect(json['errors']).to_not be_nil
      end
    end

  end

end