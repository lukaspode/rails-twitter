# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  get 'up' => 'rails/health#show', as: :rails_health_check

  devise_scope :user do
    get 'signin' => 'users/sessions#create'
    get 'signup' => 'users/registrations#new'
  end

  resources :users, only: %i[show update edit]
end
