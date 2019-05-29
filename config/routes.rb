
Rails.application.routes.draw do

  get 'site/index'

  #devise_for :users, controllers: { invitations: 'users_invitations' }


  #videos_users :link_embed
  resources :videos
  root 'site#index'

  devise_for :users do
    post '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users do
    post 'deactivate' => :show
  end

  resources :users
  #videos_users :invitations

end
