
require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :bank_transaction_lists

  resources :tags, only: [ :destroy ]

  resource :tag_manager, only: [ :show ] do
    collection do
      post :replace_with
    end
  end
  resources ':taggable_type', as: 'taggable', only: [] do
    resources :tags
  end

  #get  ':taggable_type/:taggable_id/tags', to: 'tags#index'
  #post ':taggable_type/:taggable_id/tags', to: 'tags#create'
  #delete ':taggable_type/:taggable_id/tags/:id', to: 'tags#destroy'
  
  resources :bank_transactions do
    member do
      get :approval
    end
    collection do
      get :random_untagged
      get :random_unreviewed
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "bank_transactions#index"
end
