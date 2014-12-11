Rails.application.routes.draw do

  get 'tasks/new'
  get 'tasks/create'
  get 'tasks/select_date'
  get 'tasks/user_weight', :as => "user_weight"
  get 'tasks/select_user', :as => "select_user"
  get 'task/event' => "tasks#event", :as => "event"
  post 'task/comments/create' => "comments#create"
  post 'task/attachments/create' => "attachments#create"
  get 'attachments/show',  :as => "download"

  match "tasks/participate" => "tasks#participate", :via => :post
  match "tasks/create_date" => "tasks#create_date", :via => :patch, :as => "create_date"
  get "tasks/delete_date/:task_id" => "tasks#delete_date", :as => "delete_date"
  match "tasks/create_user_weight" => "tasks#create_user_weight", :via => :patch, :as => "create_user_weight"


  resources :tasks, :except => :show

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
end
