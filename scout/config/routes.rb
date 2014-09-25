Rails.application.routes.draw do

 # sessions routes
  get '/' => 'channels#index'
  # post '/' => 'sessions#create'
  root to: 'channels#index'
  get '/search' => 'channels#index'
  post 'channels' => 'channels#hold'
end
