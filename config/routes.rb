require 'sidekiq/web'

Rails.application.routes.draw do

  # get 'errors/internal_server_error'
  # get 'errors/not_found'
  # get 'errors/bad_request'

  devise_for :users

  resources :datasets do
    resources :csv_rows, :only => [:index, :update]
    resources :visualizations, :only => [:index, :new, :create, :show, :update, :destroy] do
      resources :aggregators, :only => [:destroy]
    end
    resources :csv_headers, :only => [:index, :update, :show]
  end

  resources :dashboards, :only => [:index, :new, :create, :show, :destroy] do
    resources :shared_dashboards
  end

  resources :data_streams, :only => [:index, :new, :create, :edit, :destroy, :update] do
    resources :data_stream_files
  end

  resources :profiles, :only => [:index, :edit, :update] do
    post 'generate_token', on: :collection
  end

  resources :data_platforms, :only => [:index, :new, :create, :destroy, :edit, :update]
  resources :connections
  resources :mappings
  resources :data_mappings

  # authenticate :user, ->(user) { user.user? } do
  #   resources :user_resources # Replace with your user-specific routes
  # end

  authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      resources :platforms
      mount Sidekiq::Web => "/sidekiq"
    end
  end

  namespace :api, defaults: { format: :json } do
    resources :data_stream_files
  end

  root "datasets#index"

  get '/s/:id', to: 'short_urls#show', as: :short_url

  # match '/500', to: 'errors#internal_server_error', via: :all
  # match '/404', to: 'errors#not_found', via: :all
  # match '/400', to: 'errors#bad_request', via: :all
  # match '*path', to: 'errors#not_found', via: :all

end
