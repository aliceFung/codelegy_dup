Rails.application.routes.draw do

  devise_for :users, :controllers => {  :omniauth_callbacks => "callbacks",
                                        :sessions => 'users/sessions',
                                        :registrations => 'users/registrations' }

  root to: 'main#index'
  resources :projects, only: [:index, :create]
  resources :emails, only: [:index, :show]

  resources :memberships, :except => [:index, :new, :edit, :destroy]


end

