require 'rails_helper'

describe API::V1::SessionsController do

  describe 'routing' do
    let(:uri_pre) {'/api/v1'}
    it "routes to #create" do
      expect(post("#{uri_pre}/login")).to route_to("api/v1/sessions#create", format: :json)
    end
  end
end