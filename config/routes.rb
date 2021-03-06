Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  if Rails.env.production?
    mount Shrine.presign_endpoint(:cache) => '/presign'
  end

  root 'static_pages#home'

  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords", registrations: "users/registrations", confirmations: "users/confirmations",  unlocks: "users/unlocks"}

  devise_scope :user do
    get 'sign_out', to: 'users/sessions#destroy', path: 'sign-out'
    get 'sign_in', to: 'users/sessions#new', path: 'sign-in'
    get 'register', to: 'users/registrations#new'
  end

  resources :users, controller: 'users/users', only: [:show, :update] do
    resource :profile, controller: 'users/profiles', only: [:edit, :update]
  end

  resources :games, controller: 'games/games' do
    resources :playlists, controller: 'games/playlists' do
      resources :leagues, controller: 'leagues/leagues' do
        resources :participants, controller: 'leagues/participants', only: [:create, :destroy]
        resources :weeks, controller: 'leagues/weeks' do
          resources :matches, controller: 'leagues/matches' do
            resources :match_relationships, controller: 'leagues/match_relationships', only: [:create, :destroy]
            resources :match_votes, controller: 'leagues/match_votes', only: [:create, :destroy]
          end
        end
      end
    end
  end

end