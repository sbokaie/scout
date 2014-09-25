Rails.application.routes.draw do

 # sessions routes
  get '/' => 'channels#index'
  # post '/' => 'sessions#create'
  root to: 'channels#index'
  get '/search' => 'channels#index'
  get '/show/:id' => 'channels#show'
  post 'channels' => 'channels#hold'
end
