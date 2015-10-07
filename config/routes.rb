Rails.application.routes.draw do

  devise_for :users, :controllers => {  :omniauth_callbacks => "callbacks",
                                        :sessions => 'users/sessions',
                                        :registrations => 'users/registrations' }

  root to: 'main#index'

  scope :api do
    scope :v1 do
      resources :projects, only: [:index, :show, :create]
      resources :emails, only: [:index, :show]
      resources :languages, only: [:index]
      resources :profiles, only: [:show]
      put 'profiles' => 'profiles#update'
    end
  end
end

