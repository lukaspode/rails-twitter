# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :users, only: :show do
    resources :tweets, only: %i[new create show]
  end
  resource :user, only: %i[edit update], controller: :user
end
