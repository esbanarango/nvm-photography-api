Rails.application.routes.draw do

  devise_for :users, skip: [:sessions, :passwords, :registrations]

  # Rails-api API
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        post 'login', to: 'sessions#create', as: :session
      end

      resources :photos, except: [:edit, :new]

    end
  end

  # Documentation
  mount GrapeSwaggerRails::Engine => '/documentation' if  Rails.env =~ /development/

end
