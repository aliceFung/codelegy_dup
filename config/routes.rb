Rails.application.routes.draw do

  devise_for :users, :controllers => {  :omniauth_callbacks => "callbacks",
                                        :sessions => 'users/sessions',
                                        :registrations => 'users/registrations' }

  root to: 'main#index'


  scope :api do
    scope :v1 do
      resources :projects, only: [:index, :show, :create]
      resources :languages, only: [:index]
      resources :memberships, except: [:new, :edit, :destroy]
      resources :profiles, only: [:create, :update]
      # resources :emails, only: [:index, :show]
      resources :mailbox, only: [:index]
    end
  end

end

