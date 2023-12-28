# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :users, only: :show do
    resources :tweets, only: %i[show index], controller: 'users/tweets' do
      resources :likes, only: %i[create destroy]
    end
  end

  resources :tweets, only: %i[new create]

  resources :tweets, only: [] do
    post :like, on: :member
  end

  resources :users, only: [] do
    post :follow, on: :member
    resources :following, only: :index, controller: 'users/following'
    resources :followers, only: :index, controller: 'users/followers'
  end

  resource :user, only: %i[edit update], controller: :user

  resources :feed, only: :index, controller: :user

  resources :search, only: :index
end
