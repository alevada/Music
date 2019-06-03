
Rails.application.routes.draw do
  #devise_for :users, controllers: { invitations: 'users_invitations' }
  #imported_videos :link_embed

  get 'site/index'
  root 'site#index'

  devise_for :users do
    post '/users/sign_out' => 'devise/sessions#destroy'
  end

  post 'import_video/:id', to: 'videos#import_video', as: 'import_video'

  resources :users
  resources :videos

  get "my_videos", to: "videos#user_videos"

  delete 'delete_imported_video/:id', to: 'videos#delete_imported_video', as: 'delete_imported'

  resources :users do
    post 'deactivate' => :show
  end

end
