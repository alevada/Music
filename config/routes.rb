
Rails.application.routes.draw do

  resources :imported_videos
  resources :videos

  root to: 'videos#index'

  devise_for :users do
    post '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
