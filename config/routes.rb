Rails.application.routes.draw do
  get 'movies/index'

  get 'movies/show'

  get 'welcome/index'

  root 'welcome#index'
  get 'welcome' => 'welcome#index'

  devise_for :users
end
