Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    registrations: 'accounts/registrations',
    confirmations: 'accounts/confirmations',
    passwords: 'accounts/passwords',
    unlocks: 'accounts/unlocks'
  }

  resources :projects do
    resources :tasks, only: [:new, :create]
  end

  resources :tasks do
    member do
      post :update_status
    end
  end

  root to: "projects#index"
end