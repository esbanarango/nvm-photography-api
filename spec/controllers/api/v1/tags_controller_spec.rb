require 'rails_helper'

describe API::V1::TagsController do

  it { expect(subject.class.superclass.name).to eq('API::V1::BaseController') }

  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  let!(:tag) { create_list(:tag, 30) }

  shared_examples('Forbidden access') do
    describe 'GET#index' do
      it 'returns an error message' do
        get :index
        expect(response).to_not be_success
        expect(json['error']).to_not be_nil
      end
    end
  end

  describe 'Non logged in access' do
    it_behaves_like 'Forbidden access'
  end

  shared_examples('Allowed access') do

    describe 'GET#index' do

      it 'returns all tags' do
        get :index, per_page: 100
        expect(response).to be_success
        expect(json['tags'].length).to eq(30)
      end

      describe 'Pagination' do
        context 'when `per_page` is a number' do
          it "returns the number of tags passed on `per_page`" do
            get :index, per_page: 5
            expect(response).to be_success
            expect(json['tags'].length).to eq(5)
          end
        end
        context 'when `per_page` is set to `all`' do
          it "returns all tags" do
            get :index, per_page: 'all'
            expect(response).to be_success
            expect(json['tags'].length).to eq(Tag.count)
          end
        end
        context 'when `per_page` is set to `NaN`' do
          it "returns all tags" do
            get :index, per_page: 'NaN'
            expect(response).to be_success
            expect(json['tags'].length).to eq(Tag.count)
          end
        end
      end

      describe 'Ordering' do
        it 'sorts by `sort` param' do
          get :index, sort: 'name'
          expect(response).to be_success
          tags = assigns(:active_model_instance)
          for i in 0..(tags.length - 2)
            expect(tags[i].name).to be > tags[i+1].name
          end
        end
      end
    end
  end

  describe 'Admin access' do

    let(:admin) {create(:admin)}

    before do
      sign_in admin
    end

    it_behaves_like 'Allowed access'
  end

end
