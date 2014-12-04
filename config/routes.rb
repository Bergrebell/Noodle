Rails.application.routes.draw do

  #match ':controller(/:action(/:id))(.:format)', via: [:get, :post]

  get 'tasks/new'
  get 'tasks/create'
  get 'tasks/select_date'
  get 'tasks/user_weight', :as => "user_weight"
  get 'tasks/select_user', :as => "select_user"
  get 'task/event' => "tasks#event", :as => "event"
  post 'task/comments/create' => "comments#create"

  match "tasks/participate" => "tasks#participate", :via => :post
  match "tasks/create_date" => "tasks#create_date", :via => :patch, :as => "create_date"
  match "tasks/delete_date" => "tasks#delete_date", :via => :delete, :as => "delete_date"
  match "tasks/create_user_weight" => "tasks#create_user_weight", :via => :patch, :as => "create_user_weight"


  resources :tasks

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "account" => "sessions#account", :as => "account"

  get "addfriends" => "friendships#new", :as => "addfriends"

  resources :users do
    collection do
      post 'multiple_update'
    end
  end



  resources :sessions
  resources :friendships
  resources :responses



  root 'welcome#index'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
