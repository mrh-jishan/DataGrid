require 'sidekiq/web'

Rails.application.routes.draw do

  resources :file_uploads, :only => [:index, :new, :create, :show, :update] do
    resources :visualizations, :only => [:index, :create, :show]
    resources :csv_headers, :only => [:index], defaults: { format: :json } do
      member do
        patch 'update_data_type', to: 'csv_headers#update_data_type', as: 'csv_rows'
      end
    end
    resources :csv_rows, :only => [:index]
    resources :dashboards, :only => [:index]
    member do
      patch 'csv_rows/:csv_row_id', to: 'file_uploads#update', as: 'csv_rows'
    end
  end

  mount Sidekiq::Web => "/sidekiq"

  root "home#index"

end
