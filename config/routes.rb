# frozen_string_literal: true

PaidUp::Engine.routes.draw do
  resources :plans, only: :index do
    resources :subscriptions, only: %i(new create)
  end

  resources :subscriptions, only: [:index]
end
