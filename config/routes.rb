Rails.application.routes.draw do

  root to: "main#index"

  resources :emails, :only => [:index, :show]
end
