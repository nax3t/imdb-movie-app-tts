Rails.application.routes.draw do
  # root route - home page
  root 'welcome#index'
  # landing page/ home page
  get 'welcome' => 'welcome#index'
  # devise user routes (signup, login, etc.)
  devise_for :users
  # nested user's movies routes
  resources :users, only: [:show] do
    resources :movies, only: [:index, :show, :create, :destroy], shallow: true do
      resources :reviews, only: [:create, :edit, :update, :destroy], shallow: true
    end
  end


  # search movies route
  get 'search' => 'movies#search' # search_path => /search
  # movie details route
  get 'details/:imdb_id' => 'movies#details', as: 'details' # details_path(:id) => /details/:id
end