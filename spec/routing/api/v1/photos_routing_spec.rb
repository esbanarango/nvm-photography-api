require 'rails_helper'

describe API::V1::PhotosController do

  describe 'routing' do
    let(:uri_pre) {'/api/v1'}
    it "routes to #index" do
      expect(get("#{uri_pre}/photos")).to route_to("api/v1/photos#index", format: :json)
    end

    it "routes to #show" do
      expect(get("#{uri_pre}/photos/1")).to route_to("api/v1/photos#show", format: :json, id: '1')
    end

    it "routes to #create" do
      expect(post("#{uri_pre}/photos")).to route_to("api/v1/photos#create", format: :json)
    end

    it "routes to #update" do
      expect(put("#{uri_pre}/photos/1")).to route_to("api/v1/photos#update", format: :json, id: '1')
    end

    it "routes to #destroy" do
      expect(delete("#{uri_pre}/photos/1")).to route_to("api/v1/photos#destroy", format: :json, id: '1')
    end
  end
end