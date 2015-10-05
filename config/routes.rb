Rails.application.routes.draw do

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root to: "main#index"

  resources :emails, :only => [:index, :show]
  resources :memberships, :except => [:index, :new, :edit, :destroy]

  resources :projects, only: [:index, :create]


  resources :emails, only: [:index, :show]

end

