# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :auth do
    post '/signup', to: 'signup#sign_up'
    post '/signin', to: 'signin#sign_in'
    post '/refresh_token', to: 'refresh#refresh_token'
    delete 'signin', to: 'signin#sign_out'
  end

  resources :todos

end
