# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only: %i[show index]
      resources :videos, only: [:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :tutorials, only: %i[create edit update destroy new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: %i[edit update destroy]

    namespace :api do
      namespace :v1 do
        put 'tutorial_sequencer/:tutorial_id', to: 'tutorial_sequencer#update'
      end
    end
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'
  post '/add_friend', to: 'friendships#create'
  get '/invite', to: 'invite_email#new'
  post '/invite', to: 'invite_email#create'

  # mailer
  post '/notifications' => 'notifications#create'

  # confirmation_email
  get '/:token/confirm_email', to: 'verification_email_notifier#update'

  # Is this being used?
  get '/video', to: 'video#show'

  resources :users, only: %i[new create update edit]

  resources :tutorials, only: %i[show index] do
    resources :videos, only: %i[show index]
  end

  resources :user_videos, only: %i[create destroy]

  # GITHUBAPI
  get 'auth/github', as: 'github_login'
  get '/auth/github/callback', to: 'github#create'
end
