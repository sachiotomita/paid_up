# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  mount PaidUp::Engine => '/', as: 'paid_up'
end
