Rails.application.routes.draw do
  resources :tasks
  resources :groups
  get '/groups/:id/add_task' => 'groups#add_task'
  post '/groups/:id/add_task' => 'groups#add_task_to_group'
  get '/join_group' => 'groups#join_group_p'
  post '/join_group' => 'groups#join_group'
  get 'users/show'
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :notes
  get 'static_pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'static_pages#home'

  # add a route for add task

end
