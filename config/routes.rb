Rails.application.routes.draw do

  root to: 'main#index'

  scope :api do
    scope :v1 do
      devise_for :users, :controllers => {  :omniauth_callbacks => "callbacks",
                                            :sessions => 'users/sessions',
                                            :registrations => 'users/registrations',
                                            :passwords => 'users/passwords',
                                            :confirmations => 'users/confirmations' }
      resources :projects, only: [:index, :show, :create, :update]
      resources :languages, only: [:index]
      resources :timeslots, only: [:create]
      resources :memberships, except: [:new, :edit, :destroy]
      resources :mailbox, only: [:index, :create, :destroy]
      resources :photos, only: [:create, :update, :destroy]

      put 'profiles' => 'profiles#update'
      get 'profiles' => 'profiles#show'
      post 'resubscribe', to: 'subscriptions#resubscribe'
    end
  end

end

