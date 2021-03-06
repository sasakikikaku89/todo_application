Rails.application.routes.draw do
  # 詳細検索の件
  get "users/:id/my_tasks" => "users#my_tasks"
  get "tasks/index/search" => "tasks#search"

  post "logout" => "users#logout"

  post "login" => "users#login"
  get "login" => "users#login_form"
  
  patch "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"

  get "signup" => "users#new"
  post "users/create" => "users#create"

  get "users/index" => "users#index"
  get "users/:id" => "users#show"
  
  get "tasks/index" => "tasks#index"
  get "tasks/new" => "tasks#new"
  get "tasks/:id" => "tasks#show"
  
  post "tasks/create" => "tasks#create"
  
  
  get "tasks/:id/edit" => "tasks#edit"
  patch "tasks/:id/update" => "tasks#update"

  post "tasks/:id/destroy" => "tasks#destroy"

  get "/" => "home#top"
  get "/about" => "home#about"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
end
