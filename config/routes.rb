require 'sidekiq/web'

Rails.application.routes.draw do

  # get 'errors/internal_server_error'
  # get 'errors/not_found'
  # get 'errors/bad_request'

  devise_for :users

  resources :file_uploads, :only => [:index, :new, :create, :show, :update, :destroy] do
    resources :visualizations, :only => [:index, :new, :create, :show, :update, :destroy] do
      resources :aggregators, :only => [:destroy]
    end
    resources :csv_headers, :only => [:index, :update, :show]
    resources :csv_rows, :only => [:index]
    member do
      patch 'csv_rows/:csv_row_id', to: 'file_uploads#update', as: 'csv_rows'
    end
  end

  resources :dashboards, :only => [:index, :new, :create, :show, :destroy]
  resources :data_platforms, :only => [:index, :new, :create]
  resources :connections

  root "file_uploads#index"

  mount Sidekiq::Web => "/sidekiq"
  # match '/500', to: 'errors#internal_server_error', via: :all
  # match '/404', to: 'errors#not_found', via: :all
  # match '/400', to: 'errors#bad_request', via: :all

end
