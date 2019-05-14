
Rails.application.routes.draw do

  get 'site/index'

  #devise_for :users, controllers: { invitations: 'users_invitations' }


  resources :link_embed
  resources :videos

  root 'site#index'
  #root to: 'videos#index'

  devise_for :users do
    post '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users
  resources :invitations

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
