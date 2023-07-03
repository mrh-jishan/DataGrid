require 'sidekiq/web'

Rails.application.routes.draw do
  # get 'csv_rows/index'
  # get 'dashboards/index'
  # get 'dashboard/index'

  root "home#index"
  resources :file_uploads, :only => [:index, :new, :create, :show, :update] do
    resources :csv_headers, :only => [:index], defaults: { format: :json }
    resources :csv_rows, :only => [:index]
    resources :dashboards, :only => [:index]
    member do
      patch 'csv_rows/:csv_row_id', to: 'file_uploads#update', as: 'csv_rows'
    end
  end

  mount Sidekiq::Web => "/sidekiq"

end
