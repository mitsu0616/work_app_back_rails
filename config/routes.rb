Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'users/test', to: 'users#test'
  get 'users', to: 'users#index'
  get 'user', to: 'users#get_by_mail'
  post 'users', to: 'users#create'
  
  resources :work_hours, only: [:index, :create]
  put 'work_hours', to: 'work_hours#update'
  delete 'work_hours/:id', to: 'work_hours#destroy'
  get 'work_hour', to: 'work_hours#get_date'
end
