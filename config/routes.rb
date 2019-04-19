
Rails.application.routes.draw do

  #devise_for :users, controllers: { invitations: 'users_invitations' }


  resources :imported_videos
  resources :videos

  root to: 'videos#index'

  devise_for :users do
    post '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users
  resources :invitations

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
