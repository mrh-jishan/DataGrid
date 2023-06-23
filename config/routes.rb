require 'sidekiq/web'

Rails.application.routes.draw do

  root "home#index"
  resources :file_uploads, :only => [:index, :new, :create, :show, :update] do
    member do
      patch 'csv_rows/:csv_row_id', to: 'file_uploads#update', as: 'csv_rows'
    end
  end

  mount Sidekiq::Web => "/sidekiq"

end
