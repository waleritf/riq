Rails.application.routes.draw do
  root 'artists#index'

  resources :artists, only: [:index] do
    scope modue: :artists do
      resources :albums, only: [:index]
    end
  end
  resources :albums,  only: [:index] do
    scope module: :albums do
      resources :tracks, only: [:index]
    end
  end
  resources :tracks,  only: [:index, :new, :create, :destroy]
  resources :playlists, only: [:index, :show, :new, :create, :destroy]

  resource :on_air_playlist, only: [:create, :destroy]
end
