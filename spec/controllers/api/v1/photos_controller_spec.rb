require 'rails_helper'

describe API::V1::PhotosController do

  it { expect(subject.class.superclass.name).to eq('API::V1::BaseController') }

  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  let!(:photo) { create(:photo) }

  shared_examples('Non logged access') do

    describe 'GET#index' do

      before do
        create_list(:photo, 10)
      end

      it 'collects photos into @photos' do
        get :index, per_page: 100
        expect(response).to be_success
        expect(json['photos'].length).to eq(11)
      end

      describe 'Pagination' do
        context 'when `per_page` is a number' do
          it "returns the number of photos passed on `per_page`" do
            get :index, per_page: 5
            expect(response).to be_success
            expect(json['photos'].length).to eq(5)
          end
        end
        context 'when `per_page` is set to `all`' do
          it "returns all photos" do
            get :index, per_page: 'all'
            expect(response).to be_success
            expect(json['photos'].length).to eq(Photo.count)
          end
        end
        context 'when `per_page` is set to `NaN`' do
          it "returns all photos" do
            get :index, per_page: 'NaN'
            expect(response).to be_success
            expect(json['photos'].length).to eq(Photo.count)
          end
        end
      end

      describe 'Ordering' do
        context 'when `sort` param is not provided or it\'s invalid' do
          it 'sorts by `updated_at`' do
            get :index
            expect(response).to be_success
            photos = assigns(:photos) || assigns(:active_model_instance)
            for i in 0..(photos.length - 2)
              expect(photos[i].updated_at.to_i).to be >= photos[i+1].updated_at.to_i
            end
          end
        end

        context 'when `sort` param is provided' do

          before do
            ascii = [*97..122]
            Photo.all.each_with_index do |photo, i|
              photo.update_attribute('description', ascii[i].chr)
            end
          end

          it 'sorts by `sort` param' do
            get :index, sort: 'description'
            expect(response).to be_success
            photos = assigns(:photos) || assigns(:active_model_instance)
            for i in 0..(photos.length - 2)
              expect(photos[i].description).to be > photos[i+1].description
            end
          end
        end

      end

    end

    describe "GET#show" do
      it 'returns the requested photo' do
        get :show, id: photo
        expect(response).to be_success
        expect(response).to match_response_schema('v1/photos/default')
      end
    end

    describe 'POST#create' do
      it 'doesn\'t create a new photo' do
        expect {
          post :create, photo: attributes_for(:photo)
        }.to_not change(Photo, :count)
      end

      it 'returns an error message' do
        post :create, photo: attributes_for(:photo)
        expect(response).to_not be_success
        expect(json['error']).to_not be_nil
      end
    end

    describe 'PUT#update' do

      it 'returns an error message' do
        put :update, id: photo, photo: {code: 'New code'}
        expect(response).to_not be_success
        expect(json['error']).to_not be_nil
      end

    end

    describe 'DELETE#destroy' do
      it 'doesn\'t destroy the requested photo' do
        expect {
          delete :destroy, id: photo
        }.to_not change(Photo, :count)
      end

      it 'returns an error message' do
        delete :destroy, id: photo
        expect(json['error']).to_not be_nil
      end
    end

  end

  describe 'Non logged in access' do
    it_behaves_like 'Non logged access'
  end

  shared_examples('Allowed access') do

    describe "POST#create" do

      context 'with valid params' do
        it 'creates a new photo' do
          expect {
            post :create, photo: attributes_for(:photo)
          }.to change(Photo, :count).by(1)
        end

        it "returns the created photo" do
          post :create, photo: attributes_for(:photo)
          expect(response).to be_success
          expect(response).to match_response_schema('v1/photos/default')
        end

      end


      context 'with invalid params' do
        it 'doesn\'t create a new photo' do
          expect {
            post :create, photo: attributes_for(:invalid_photo)
          }.to change(Photo, :count).by(0)
        end

        it 'returns the error message' do
          post :create, photo: attributes_for(:invalid_photo)
          expect(response).not_to be_success
          expect(json['errors']).not_to be_nil
        end

      end

    end


    describe 'PUT#update' do

      context 'with valid params' do
        let(:valid_params_to_update) {{exposure: 'fsdf'}}
        it 'updates the photo' do
          # Assuming there are no other photos in the database, this
          # specifies that the Photo created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          allow_any_instance_of(Photo).to receive(:update).with(valid_params_to_update)
          put :update, id: photo, photo: valid_params_to_update
          expect(response).to be_success
        end

      end

      context 'with invalid params' do
        let(:invalid_params_to_update) {{description: ''}}
        it 'returns the error message' do
          put :update, id: photo, photo: invalid_params_to_update
          expect(response).not_to be_success
          expect(json['errors']).not_to be_nil
        end

      end
    end

    describe 'DELETE#destroy' do
      it 'destroys the requested photo' do
        expect {
          delete :destroy, id: photo
        }.to change(Photo, :count).by(-1)
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