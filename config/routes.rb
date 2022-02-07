
require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :bank_transaction_lists

  resources ':taggable_type', as: 'taggable', only: [] do
    resources :tags
  end

  #get  ':taggable_type/:taggable_id/tags', to: 'tags#index'
  #post ':taggable_type/:taggable_id/tags', to: 'tags#create'
  #delete ':taggable_type/:taggable_id/tags/:id', to: 'tags#destroy'
  
  resources :bank_transactions do
    collection do
      get :random_untagged
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
