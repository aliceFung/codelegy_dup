Rails.application.routes.draw do

  root to: "main#index"

  resources :emails, :only => [:index, :show]
  resources :memberships, :except => [:index, :new, :edit]
end
