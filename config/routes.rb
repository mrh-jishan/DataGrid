require 'sidekiq/web'

Rails.application.routes.draw do

  root "home#index"
  resources :file_uploads, :only => [:index, :new, :create, :show]

  mount Sidekiq::Web => "/sidekiq"

end
