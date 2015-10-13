Rails.application.routes.draw do

  devise_for :users, :controllers => {  :omniauth_callbacks => "callbacks",
                                        :sessions => 'users/sessions',
                                        :registrations => 'users/registrations', 
                                        :passwords => 'users/passwords' }

  root to: 'main#index'


  scope :api do
    scope :v1 do
      resources :projects, only: [:index, :show, :create]
      resources :languages, only: [:index]

      put 'profiles' => 'profiles#update'
      get 'profiles' => 'profiles#show'

      resources :memberships, except: [:new, :edit, :destroy]
      resources :mailbox, only: [:index, :create, :destroy]

    end
  end

end

