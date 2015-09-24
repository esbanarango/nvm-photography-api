require 'rails_helper'

describe API::V1::TagsController do

  describe 'routing' do
    let(:uri_pre) {'/api/v1'}
    it "routes to #index" do
      expect(get("#{uri_pre}/tags")).to route_to("api/v1/tags#index", format: :json)
    end
  end
end