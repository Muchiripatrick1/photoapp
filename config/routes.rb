Rails.application.routes.draw do
  resources :posts
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]
  root 'users#new'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
